'use client';
import { useState, useEffect, useRef, use, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSession } from 'next-auth/react';

// 1. Define the Database Types
interface Choice {
  id: number;
  choice_text: string;
  is_correct: boolean;
}

interface Question {
  id: number;
  stem_text: string;
  explanation_text: string;
  topic: string;
  choices: Choice[];
}

interface ExamLogicProps {
  examCode: string;
}

function ExamLogic({ examCode }: ExamLogicProps) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { data: session } = useSession();
  
  const mode = searchParams.get('mode') || 'practice';
  const isExamMode = mode === 'exam';
  const topic = searchParams.get('topic'); 
  
  // 2. Apply types to state
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [userAnswers, setUserAnswers] = useState<Record<number, number>>({}); 
  const [checkedQuestions, setCheckedQuestions] = useState<Record<number, boolean>>({}); 
  const [isFinished, setIsFinished] = useState<boolean>(false);
  
  const [isReviewMode, setIsReviewMode] = useState<boolean>(false);
  const [reviewIndices, setReviewIndices] = useState<number[]>([]); 
  const [reviewPosition, setReviewPosition] = useState<number>(0); 
  
  const [timeLeft, setTimeLeft] = useState<number | null>(null);
  const [eliminatedChoices, setEliminatedChoices] = useState<Record<number, number[]>>({}); 
  
  const bottomRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    let url = `/api/exams/${examCode}/generate`;
    if (topic) url += `?topic=${encodeURIComponent(topic)}`;

    fetch(url)
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          setQuestions(data.questions);
          if (isExamMode) setTimeLeft(data.questions.length * 120);
        }
        setLoading(false);
      })
      .catch(err => console.error(err));
  }, [examCode, isExamMode, topic]);

  useEffect(() => {
    if (timeLeft === null || timeLeft <= 0 || isFinished || isReviewMode) return;
    const timerId = setInterval(() => setTimeLeft(prev => (prev !== null ? prev - 1 : null)), 1000);
    return () => clearInterval(timerId);
  }, [timeLeft, isFinished, isReviewMode]);

  useEffect(() => {
    if (timeLeft === 0 && !isFinished) {
      setIsFinished(true);
      alert("Time is up! Your exam has been automatically submitted.");
    }
  }, [timeLeft, isFinished]);

  const formatTime = (seconds: number | null) => {
    if (seconds === null) return "";
    const m = Math.floor(seconds / 60).toString().padStart(2, '0');
    const s = (seconds % 60).toString().padStart(2, '0');
    return `${m}:${s}`;
  };

  const calculateScore = () => {
    let correct = 0;
    let incorrect = 0;
    let missed: number[] = []; 
    let topicBreakdown: Record<string, { correct: number, total: number }> = {}; 
    
    questions.forEach((q, index) => {
      const selectedChoiceId = userAnswers[index];
      const correctChoice = q.choices.find(c => c.is_correct);
      const isCorrect = selectedChoiceId === correctChoice?.id;

      if (!topicBreakdown[q.topic]) {
        topicBreakdown[q.topic] = { correct: 0, total: 0 };
      }
      
      topicBreakdown[q.topic].total++;

      if (isCorrect) {
        correct++;
        topicBreakdown[q.topic].correct++;
      } else {
        incorrect++;
        missed.push(index);
      }
    });
    return { correct, incorrect, total: questions.length, missed, topicBreakdown };
  };

  // Save Scores
  useEffect(() => {
    if (isFinished && !isReviewMode) {
      const { correct, total, topicBreakdown } = calculateScore();
      const percentage = Math.round((correct / total) * 100);
      
      const recentModeName = isExamMode ? 'Exam' : (topic ? 'Targeted Practice' : 'Practice');
      const recent = { examCode, percentage, mode: recentModeName };
      localStorage.setItem('ase_recent', JSON.stringify(recent));

      if (isExamMode && !topic) {
        const highScores = JSON.parse(localStorage.getItem('ase_highscores') || '{}');
        if (!highScores[examCode] || percentage > highScores[examCode]) {
          highScores[examCode] = percentage;
          localStorage.setItem('ase_highscores', JSON.stringify(highScores));
        }

        const savedTopics = JSON.parse(localStorage.getItem('ase_topics') || '{}');
        if (!savedTopics[examCode]) savedTopics[examCode] = {}; 
        
        Object.entries(topicBreakdown).forEach(([t, stats]) => {
          if (!savedTopics[examCode][t]) {
            savedTopics[examCode][t] = { correct: 0, total: 0 };
          }
          savedTopics[examCode][t].correct += stats.correct;
          savedTopics[examCode][t].total += stats.total;
        });
        localStorage.setItem('ase_topics', JSON.stringify(savedTopics));

        fetch('/api/scores', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            username: session?.user?.email || 'Guest',
            examCode: examCode,
            percentage: percentage,
            mode: recentModeName,
            topicData: topicBreakdown
          })
        })
        .then(res => res.json())
        .then(data => console.log("Score saved to DB:", data))
        .catch(err => console.error("Failed to save score:", err));
      }
    }
  }, [isFinished, isReviewMode, isExamMode, examCode, topic, session]);
  
  const activeIndex = isReviewMode ? reviewIndices[reviewPosition] : currentIndex;

  const handleHint = () => {
    if (eliminatedChoices[activeIndex]) return; 
    const currentQ = questions[activeIndex];
    const incorrectChoices = currentQ.choices.filter(c => !c.is_correct);
    
    const shuffled = incorrectChoices.sort(() => 0.5 - Math.random());
    const toEliminate = shuffled.slice(0, 2).map(c => c.id);
    
    setEliminatedChoices(prev => ({ ...prev, [activeIndex]: toEliminate }));
  };

  const handleSelectAnswer = (choiceId: number) => {
    if (isReviewMode) return;
    if (!isExamMode && checkedQuestions[activeIndex]) return;
    setUserAnswers(prev => ({ ...prev, [activeIndex]: choiceId }));
  };

  const handleCheckAnswer = () => {
    setCheckedQuestions(prev => ({ ...prev, [activeIndex]: true }));
    setTimeout(() => {
      bottomRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
  };

  const handleNext = () => {
    if (isReviewMode) {
      if (reviewPosition < reviewIndices.length - 1) {
        setReviewPosition(reviewPosition + 1);
        window.scrollTo({ top: 0, behavior: 'smooth' });
      } else {
        setIsReviewMode(false);
        setIsFinished(true);
      }
    } else {
      if (currentIndex < questions.length - 1) {
        setCurrentIndex(currentIndex + 1);
        window.scrollTo({ top: 0, behavior: 'smooth' }); 
      } else {
        setIsFinished(true);
      }
    }
  };

  const handleBack = () => {
    if (isReviewMode) {
      if (reviewPosition > 0) {
        setReviewPosition(reviewPosition - 1);
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    } else {
      if (currentIndex > 0) {
        setCurrentIndex(currentIndex - 1);
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }
    }
  };

  const startReview = (missedIndices: number[]) => {
    if (missedIndices.length === 0) {
      alert("You got a perfect score! There are no missed questions to review.");
      return;
    }
    setReviewIndices(missedIndices);
    setReviewPosition(0);
    setIsFinished(false);
    setIsReviewMode(true);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  if (loading) return <div className="p-8 text-center dark:text-gray-200">Loading ASE {examCode} Data...</div>;
  if (questions.length === 0) return <div className="p-8 text-center dark:text-gray-200">No questions found for this selection.</div>;

  if (isFinished) {
    const { correct, incorrect, total, missed, topicBreakdown } = calculateScore();
    const percentage = Math.round((correct / total) * 100);
    
    return (
      <div className="max-w-2xl mx-auto p-4 md:p-8 mt-4 md:mt-10 bg-white dark:bg-gray-800 rounded-xl shadow-md text-center transition-colors">
        <h1 className="text-2xl md:text-3xl font-bold mb-2 text-gray-900 dark:text-white">{isExamMode ? 'Exam Complete!' : 'Practice Complete!'}</h1>
        
        {!isExamMode && (
          <p className="text-xs md:text-sm text-orange-600 dark:text-orange-400 font-bold mb-4 bg-orange-50 dark:bg-orange-900/20 inline-block px-3 py-1 rounded border border-orange-200 dark:border-orange-800">
            Practice scores are not saved to your Performance Profile.
          </p>
        )}

        <div className="text-5xl md:text-6xl font-bold mb-4 text-blue-600 dark:text-blue-400">{percentage}%</div>
        
        <div className="flex justify-center gap-8 mb-8 text-lg md:text-xl border-b dark:border-gray-700 pb-6">
          <div className="text-green-600 dark:text-green-400 font-semibold">Correct: {correct}</div>
          <div className="text-red-600 dark:text-red-400 font-semibold">Incorrect: {incorrect}</div>
        </div>

        <div className="mb-8 text-left">
          <h2 className="text-lg md:text-xl font-bold mb-4 text-gray-800 dark:text-gray-200">Performance by Category</h2>
          <div className="space-y-3">
            {Object.entries(topicBreakdown).map(([t, stats]) => {
              const topicPercent = Math.round((stats.correct / stats.total) * 100);
              return (
                <div key={t} className="flex flex-col md:flex-row justify-between md:items-center bg-gray-50 dark:bg-gray-700/50 p-3 rounded border dark:border-gray-600 gap-2 md:gap-0">
                  <span className="font-medium text-gray-700 dark:text-gray-300 text-sm md:text-base">{t}</span>
                  <div className="flex items-center justify-between md:justify-end gap-4 w-full md:w-auto">
                    <span className="text-sm text-gray-500 dark:text-gray-400">{stats.correct} / {stats.total}</span>
                    <span className={`font-bold w-12 text-right ${topicPercent >= 80 ? 'text-green-600 dark:text-green-400' : topicPercent >= 60 ? 'text-yellow-600 dark:text-yellow-400' : 'text-red-600 dark:text-red-400'}`}>
                      {topicPercent}%
                    </span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        <div className="flex flex-col sm:flex-row justify-center gap-4">
          <button 
            onClick={() => startReview(missed)}
            disabled={missed.length === 0}
            className="bg-gray-600 dark:bg-gray-700 text-white px-6 py-3 rounded hover:bg-gray-700 dark:hover:bg-gray-600 transition-colors disabled:opacity-50"
          >
            Review Missed Questions
          </button>
          <button 
            onClick={() => router.push('/')}
            className="bg-blue-600 dark:bg-blue-500 text-white px-6 py-3 rounded hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors"
          >
            Return to Home
          </button>
        </div>
      </div>
    );
  }

  const currentQuestion = questions[activeIndex];
  const currentSelectedAnswer = userAnswers[activeIndex];
  const showResults = isReviewMode || (!isExamMode && checkedQuestions[activeIndex]);

  return (
    <div className="max-w-3xl mx-auto p-4 md:p-8 mt-4 md:mt-8 bg-white dark:bg-gray-800 rounded-xl shadow-md mb-10 relative transition-colors border dark:border-gray-700">
      
      <div className="flex flex-col md:flex-row justify-between md:items-center mb-4 border-b dark:border-gray-700 pb-4 gap-4 md:gap-0">
        <h1 className="text-xl md:text-2xl font-bold text-gray-900 dark:text-white">
          ASE {examCode} {isExamMode ? 'Exam' : 'Practice'} 
          {topic && <span className="text-blue-600 dark:text-blue-400 ml-2 text-base md:text-lg block md:inline">({topic} Focus)</span>}
          {isReviewMode && <span className="text-red-500 dark:text-red-400 ml-2 block md:inline">(Review Missed)</span>}
        </h1>
        
        <div className="flex items-center justify-between md:justify-end gap-4 w-full md:w-auto">
          {isExamMode && !isFinished && timeLeft !== null && (
            <span className={`font-mono text-lg font-bold ${timeLeft < 60 ? 'text-red-600 dark:text-red-400 animate-pulse' : 'text-gray-700 dark:text-gray-300'}`}>
              ⏱ {formatTime(timeLeft)}
            </span>
          )}
          <button 
            onClick={() => router.push('/')}
            className="text-gray-500 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 font-medium transition-colors flex items-center gap-1"
            title="Exit to Home"
          >
            ✕ Exit
          </button>
        </div>
      </div>

      <div className="flex flex-col md:flex-row justify-between md:items-center mb-6 gap-2 md:gap-0">
        <p className="text-sm text-gray-500 dark:text-gray-400">
          {isReviewMode 
            ? `Reviewing Missed Question ${reviewPosition + 1} of ${reviewIndices.length}`
            : `Question ${currentIndex + 1} of ${questions.length}`
          }
        </p>
        <span className="text-xs font-bold bg-blue-100 dark:bg-blue-900/40 text-blue-800 dark:text-blue-300 px-2 py-1 rounded uppercase tracking-wider self-start md:self-auto">
          {currentQuestion.topic}
        </span>
      </div>
      
      <p className="text-lg md:text-xl font-medium mb-8 text-gray-800 dark:text-gray-200 leading-relaxed">{currentQuestion.stem_text}</p>
      
      <div className="space-y-3 mb-8">
        {currentQuestion.choices.map((choice) => {
          const isEliminated = eliminatedChoices[activeIndex]?.includes(choice.id);
          let btnClass = "w-full text-left p-4 border rounded-lg transition-all duration-200 ";
          
          if (isEliminated) {
            btnClass += "opacity-40 cursor-not-allowed bg-gray-100 dark:bg-gray-800 text-gray-400 dark:text-gray-600 border-gray-200 dark:border-gray-700";
          } else if (showResults) {
            if (choice.is_correct) {
              btnClass += "bg-green-100 dark:bg-green-900/30 border-green-500 dark:border-green-500 text-green-900 dark:text-green-100"; 
            } else if (currentSelectedAnswer === choice.id) {
              btnClass += "bg-red-100 dark:bg-red-900/30 border-red-500 dark:border-red-500 text-red-900 dark:text-red-100"; 
            } else {
              btnClass += "bg-gray-50 dark:bg-gray-700/50 border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400"; 
            }
          } else {
            btnClass += currentSelectedAnswer === choice.id 
              ? "bg-blue-50 dark:bg-blue-900/40 border-blue-500 dark:border-blue-400 text-blue-900 dark:text-blue-100" 
              : "bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-700 dark:text-gray-200";
          }
          
          return (
            <button 
              key={choice.id} 
              onClick={() => handleSelectAnswer(choice.id)} 
              className={btnClass} 
              disabled={showResults || isEliminated}
            >
              {choice.choice_text}
            </button>
          );
        })}
      </div>

      {showResults && (
        <div className="bg-blue-50 dark:bg-blue-900/20 p-5 rounded-lg mb-8 border border-blue-200 dark:border-blue-800">
          <p className="font-bold text-blue-800 dark:text-blue-300 mb-2">Explanation:</p>
          <p className="text-blue-900 dark:text-blue-100 leading-relaxed">{currentQuestion.explanation_text}</p>
        </div>
      )}

      <div className="flex flex-col-reverse md:flex-row justify-between items-center mt-6 gap-4 md:gap-0">
        <button 
          onClick={handleBack} 
          disabled={isReviewMode ? reviewPosition === 0 : currentIndex === 0} 
          className="w-full md:w-auto bg-gray-500 dark:bg-gray-600 text-white px-6 py-3 md:py-2 rounded-lg disabled:opacity-50 hover:bg-gray-600 dark:hover:bg-gray-500 transition-colors font-medium"
        >
          Back
        </button>

        <div className="flex flex-col md:flex-row gap-3 w-full md:w-auto">
          {!isExamMode && !showResults && !eliminatedChoices[activeIndex] && (
            <button 
              onClick={handleHint}
              className="w-full md:w-auto bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 px-4 py-3 md:py-2 rounded-lg hover:bg-purple-200 dark:hover:bg-purple-900/50 transition-colors font-semibold text-sm border border-purple-200 dark:border-purple-800"
            >
              💡 50/50 Hint
            </button>
          )}

          {isReviewMode ? (
            <button onClick={handleNext} className="w-full md:w-auto bg-green-600 dark:bg-green-500 text-white px-6 py-3 md:py-2 rounded-lg hover:bg-green-700 dark:hover:bg-green-600 transition-colors font-medium">
              {reviewPosition < reviewIndices.length - 1 ? 'Next Missed' : 'Finish Review'}
            </button>
          ) : isExamMode ? (
            <button onClick={handleNext} disabled={!currentSelectedAnswer} className="w-full md:w-auto bg-blue-600 dark:bg-blue-500 text-white px-6 py-3 md:py-2 rounded-lg disabled:opacity-50 hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors font-medium">
              {currentIndex < questions.length - 1 ? 'Next Question' : 'Finish Exam'}
            </button>
          ) : !checkedQuestions[activeIndex] ? (
            <button onClick={handleCheckAnswer} disabled={!currentSelectedAnswer} className="w-full md:w-auto bg-blue-600 dark:bg-blue-500 text-white px-6 py-3 md:py-2 rounded-lg disabled:opacity-50 hover:bg-blue-700 dark:hover:bg-blue-600 transition-colors font-medium">
              Check Answer
            </button>
          ) : (
            <button onClick={handleNext} className="w-full md:w-auto bg-green-600 dark:bg-green-500 text-white px-6 py-3 md:py-2 rounded-lg hover:bg-green-700 dark:hover:bg-green-600 transition-colors font-medium">
              {currentIndex < questions.length - 1 ? 'Next Question' : 'Finish Practice'}
            </button>
          )}
        </div>
      </div>

      <div ref={bottomRef} className="h-4"></div>
    </div>
  );
}

export default function TestPage({ params }: { params: Promise<{ examCode: string }> }) {
  const { examCode } = use(params);
  return (
    <Suspense fallback={<div className="p-8 text-center dark:text-gray-200">Loading Exam Data...</div>}>
      <ExamLogic examCode={examCode} />
    </Suspense>
  );
}