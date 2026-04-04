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
      
      // Always save recent test to local storage so the user sees what they just did
      const recentModeName = isExamMode ? 'Exam' : (topic ? 'Targeted Practice' : 'Practice');
      const recent = { examCode, percentage, mode: recentModeName };
      localStorage.setItem('ase_recent', JSON.stringify(recent));

      // ONLY save to Database and High Scores if in EXAM MODE (and not a targeted subset)
      if (isExamMode && !topic) {
        
        // 1. Save to Local Storage (for immediate UI updates)
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

        // 2. NEW: Send data to our backend API to save permanently in PostgreSQL
        fetch('/api/scores', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            username: session?.user?.email || 'Guest', // <-- CRITICAL FIX
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
  }, [isFinished, isReviewMode, isExamMode, examCode, topic, session]); // <-- Make sure session is in this array!
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

  if (loading) return <div className="p-8 text-center">Loading ASE {examCode} Data...</div>;
  if (questions.length === 0) return <div className="p-8 text-center">No questions found for this selection.</div>;

  if (isFinished) {
    const { correct, incorrect, total, missed, topicBreakdown } = calculateScore();
    const percentage = Math.round((correct / total) * 100);
    
    return (
      <div className="max-w-2xl mx-auto p-8 mt-10 bg-white rounded-lg shadow-md text-black text-center">
        <h1 className="text-3xl font-bold mb-2">{isExamMode ? 'Exam Complete!' : 'Practice Complete!'}</h1>
        
        {!isExamMode && (
          <p className="text-sm text-orange-600 font-bold mb-4 bg-orange-50 inline-block px-3 py-1 rounded border border-orange-200">
            Practice scores are not saved to your Performance Profile.
          </p>
        )}

        <div className="text-6xl font-bold mb-4 text-blue-600">{percentage}%</div>
        
        <div className="flex justify-center gap-8 mb-8 text-xl border-b pb-6">
          <div className="text-green-600 font-semibold">Correct: {correct}</div>
          <div className="text-red-600 font-semibold">Incorrect: {incorrect}</div>
        </div>

        <div className="mb-8 text-left">
          <h2 className="text-xl font-bold mb-4 text-gray-800">Performance by Category</h2>
          <div className="space-y-3">
            {Object.entries(topicBreakdown).map(([t, stats]) => {
              const topicPercent = Math.round((stats.correct / stats.total) * 100);
              return (
                <div key={t} className="flex justify-between items-center bg-gray-50 p-3 rounded border">
                  <span className="font-medium text-gray-700">{t}</span>
                  <div className="flex items-center gap-4">
                    <span className="text-sm text-gray-500">{stats.correct} / {stats.total}</span>
                    <span className={`font-bold w-12 text-right ${topicPercent >= 80 ? 'text-green-600' : topicPercent >= 60 ? 'text-yellow-600' : 'text-red-600'}`}>
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
            className="bg-gray-600 text-white px-6 py-3 rounded hover:bg-gray-700 transition-colors disabled:opacity-50"
          >
            Review Missed Questions
          </button>
          <button 
            onClick={() => router.push('/')}
            className="bg-blue-600 text-white px-6 py-3 rounded hover:bg-blue-700 transition-colors"
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
    <div className="max-w-2xl mx-auto p-6 mt-10 bg-white rounded-lg shadow-md text-black mb-10 relative">
      
      <div className="flex justify-between items-center mb-4 border-b pb-2">
        <h1 className="text-2xl font-bold">
          ASE {examCode} {isExamMode ? 'Exam' : 'Practice'} 
          {topic && <span className="text-blue-600 ml-2 text-lg">({topic} Focus)</span>}
          {isReviewMode && <span className="text-red-500 ml-2">(Review Missed)</span>}
        </h1>
        
        <div className="flex items-center gap-4">
          {isExamMode && !isFinished && timeLeft !== null && (
            <span className={`font-mono text-lg font-bold ${timeLeft < 60 ? 'text-red-600 animate-pulse' : 'text-gray-700'}`}>
              ⏱ {formatTime(timeLeft)}
            </span>
          )}
          <button 
            onClick={() => router.push('/')}
            className="text-gray-500 hover:text-red-600 font-medium transition-colors flex items-center gap-1"
            title="Exit to Home"
          >
            ✕ Exit
          </button>
        </div>
      </div>

      <div className="flex justify-between items-center mb-4">
        <p className="text-sm text-gray-500">
          {isReviewMode 
            ? `Reviewing Missed Question ${reviewPosition + 1} of ${reviewIndices.length}`
            : `Question ${currentIndex + 1} of ${questions.length}`
          }
        </p>
        <span className="text-xs font-bold bg-blue-100 text-blue-800 px-2 py-1 rounded uppercase tracking-wider">
          {currentQuestion.topic}
        </span>
      </div>
      
      <p className="text-lg font-medium mb-6">{currentQuestion.stem_text}</p>
      
      <div className="space-y-3 mb-6">
        {currentQuestion.choices.map((choice) => {
          const isEliminated = eliminatedChoices[activeIndex]?.includes(choice.id);
          let btnClass = "w-full text-left p-4 border rounded transition-colors ";
          
          if (isEliminated) {
            btnClass += "opacity-30 cursor-not-allowed bg-gray-100 text-gray-400";
          } else if (showResults) {
            if (choice.is_correct) {
              btnClass += "bg-green-200 border-green-600"; 
            } else if (currentSelectedAnswer === choice.id) {
              btnClass += "bg-red-200 border-red-600"; 
            } else {
              btnClass += "bg-gray-50"; 
            }
          } else {
            btnClass += currentSelectedAnswer === choice.id ? "bg-blue-100 border-blue-500" : "hover:bg-gray-100";
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
        <div className="bg-blue-50 p-4 rounded mb-6 border border-blue-200">
          <p className="font-bold text-blue-800">Explanation:</p>
          <p className="text-blue-900">{currentQuestion.explanation_text}</p>
        </div>
      )}

      <div className="flex justify-between items-center mt-6">
        <button 
          onClick={handleBack} 
          disabled={isReviewMode ? reviewPosition === 0 : currentIndex === 0} 
          className="bg-gray-500 text-white px-6 py-2 rounded disabled:opacity-50 hover:bg-gray-600 transition-colors"
        >
          Back
        </button>

        <div className="flex gap-2">
          {!isExamMode && !showResults && !eliminatedChoices[activeIndex] && (
            <button 
              onClick={handleHint}
              className="bg-purple-100 text-purple-700 px-4 py-2 rounded hover:bg-purple-200 transition-colors font-semibold text-sm"
            >
              💡 50/50 Hint
            </button>
          )}

          {isReviewMode ? (
            <button onClick={handleNext} className="bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition-colors">
              {reviewPosition < reviewIndices.length - 1 ? 'Next Missed' : 'Finish Review'}
            </button>
          ) : isExamMode ? (
            <button onClick={handleNext} disabled={!currentSelectedAnswer} className="bg-blue-600 text-white px-6 py-2 rounded disabled:opacity-50 hover:bg-blue-700 transition-colors">
              {currentIndex < questions.length - 1 ? 'Next Question' : 'Finish Exam'}
            </button>
          ) : !checkedQuestions[activeIndex] ? (
            <button onClick={handleCheckAnswer} disabled={!currentSelectedAnswer} className="bg-blue-600 text-white px-6 py-2 rounded disabled:opacity-50 hover:bg-blue-700 transition-colors">
              Check Answer
            </button>
          ) : (
            <button onClick={handleNext} className="bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition-colors">
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
    <Suspense fallback={<div className="p-8 text-center">Loading Exam Data...</div>}>
      <ExamLogic examCode={examCode} />
    </Suspense>
  );
}