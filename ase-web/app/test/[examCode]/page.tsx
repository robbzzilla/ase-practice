'use client';
import { useState, useEffect, useRef, use, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSession } from 'next-auth/react';
import toast from 'react-hot-toast';

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

function ExamLogic({ examCode }: { examCode: string }) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const { data: session } = useSession();
  
  const mode = searchParams.get('mode') || 'practice';
  const isExamMode = mode === 'exam';
  const isArcadeMode = mode === 'arcade';
  const topic = searchParams.get('topic'); 
  
  const [questions, setQuestions] = useState<Question[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  
  const [currentIndex, setCurrentIndex] = useState<number>(0);
  const [userAnswers, setUserAnswers] = useState<Record<number, number>>({}); 
  const [checkedQuestions, setCheckedQuestions] = useState<Record<number, boolean>>({}); 
  const [isFinished, setIsFinished] = useState<boolean>(false);
  
  const [isReviewMode, setIsReviewMode] = useState<boolean>(false);
  const [reviewIndices, setReviewIndices] = useState<number[]>([]); 
  const [reviewPosition, setReviewPosition] = useState<number>(0); 
  
  // Timer State: Total time for Exam, Per-Question time for Arcade
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
          if (isExamMode) setTimeLeft(data.questions.length * 120); // 2 mins per question total
          if (isArcadeMode) setTimeLeft(30); // 30 seconds to start Arcade Mode
        }
        setLoading(false);
      })
      .catch(err => console.error(err));
  }, [examCode, isExamMode, isArcadeMode, topic]);

  // Timer Countdown Logic
  useEffect(() => {
    if (timeLeft === null || timeLeft <= 0 || isFinished || isReviewMode) return;
    const timerId = setInterval(() => setTimeLeft(prev => (prev !== null ? prev - 1 : null)), 1000);
    return () => clearInterval(timerId);
  }, [timeLeft, isFinished, isReviewMode]);

  // Time Up Logic
  useEffect(() => {
    if (timeLeft === 0 && !isFinished) {
      setIsFinished(true);
      if (isArcadeMode) {
        toast.error("Time's up! Arcade run finished.", { icon: '⏱️', duration: 5000 });
      } else {
        toast.error("Time is up! Your exam has been automatically submitted.", { icon: '⏱️', duration: 5000 });
      }
    }
  }, [timeLeft, isFinished, isArcadeMode]);

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
    
    // Only grade questions that were actually answered (useful for finishing early)
    const answeredCount = Object.keys(userAnswers).length;
    const totalToGrade = isExamMode ? questions.length : Math.max(answeredCount, 1);

    questions.slice(0, totalToGrade).forEach((q, index) => {
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
    return { correct, incorrect, total: totalToGrade, missed, topicBreakdown };
  };

  // Save Scores (Now saves Practice and Arcade modes too)
  useEffect(() => {
    if (isFinished && !isReviewMode) {
      const { correct, total, topicBreakdown } = calculateScore();
      const percentage = Math.round((correct / total) * 100);
      
      let recentModeName = 'Practice';
      if (isExamMode) recentModeName = 'Exam';
      if (isArcadeMode) recentModeName = 'Arcade';
      if (topic) recentModeName = 'Targeted Practice';

      // Save to DB for ALL modes so the user can track their weak points
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
      }).catch(err => console.error("Failed to save score:", err));
    }
  }, [isFinished, isReviewMode, isExamMode, isArcadeMode, examCode, topic, session]);
  
  const activeIndex = isReviewMode ? reviewIndices[reviewPosition] : currentIndex;

  const handleSelectAnswer = (choiceId: number) => {
    if (isReviewMode) return;
    if (!isExamMode && checkedQuestions[activeIndex]) return;
    setUserAnswers(prev => ({ ...prev, [activeIndex]: choiceId }));
  };

  const handleCheckAnswer = () => {
    setCheckedQuestions(prev => ({ ...prev, [activeIndex]: true }));
    
    // Arcade Mode Bonus Time Logic
    if (isArcadeMode) {
      const currentQ = questions[activeIndex];
      const correctChoice = currentQ.choices.find(c => c.is_correct);
      if (userAnswers[activeIndex] === correctChoice?.id) {
        setTimeLeft(prev => (prev !== null ? prev + 15 : null)); // +15 seconds for correct answer
        toast.success("+15 Seconds!", { icon: '⏱️', position: 'top-right' });
      } else {
        setTimeLeft(prev => (prev !== null ? Math.max(prev - 5, 0) : null)); // -5 seconds penalty
        toast.error("-5 Seconds Penalty", { icon: '⚠️', position: 'top-right' });
      }
    }

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

  const handleFinishEarly = () => {
    if (confirm("Are you sure you want to finish early? Your score will be calculated based on answered questions.")) {
      setIsFinished(true);
    }
  };

  if (loading) return <div className="p-8 text-center dark:text-gray-200">Loading ASE {examCode} Data...</div>;
  if (questions.length === 0) return <div className="p-8 text-center dark:text-gray-200">No questions found.</div>;

  if (isFinished) {
    const { correct, incorrect, total, missed, topicBreakdown } = calculateScore();
    const percentage = Math.round((correct / total) * 100);
    
    return (
      <div className="max-w-2xl mx-auto p-4 md:p-8 mt-4 md:mt-10 bg-white dark:bg-gray-800 rounded-xl shadow-md text-center transition-colors">
        <h1 className="text-2xl md:text-3xl font-bold mb-2 text-gray-900 dark:text-white">
          {isExamMode ? 'Exam Complete!' : isArcadeMode ? 'Arcade Run Over!' : 'Practice Complete!'}
        </h1>
        <div className="text-5xl md:text-6xl font-bold mb-4 text-blue-600 dark:text-blue-400">{percentage}%</div>
        <div className="flex justify-center gap-8 mb-8 text-lg md:text-xl border-b dark:border-gray-700 pb-6">
          <div className="text-green-600 dark:text-green-400 font-semibold">Correct: {correct}</div>
          <div className="text-red-600 dark:text-red-400 font-semibold">Incorrect: {incorrect}</div>
        </div>
        <div className="flex flex-col sm:flex-row justify-center gap-4">
          <button onClick={() => router.push('/')} className="bg-blue-600 dark:bg-blue-500 text-white px-6 py-3 rounded hover:bg-blue-700 transition-colors">
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
          ASE {examCode} {isExamMode ? 'Exam' : isArcadeMode ? 'Arcade Mode' : 'Practice'} 
        </h1>
        <div className="flex items-center justify-between md:justify-end gap-4 w-full md:w-auto">
          {(isExamMode || isArcadeMode) && !isFinished && timeLeft !== null && (
            <span className={`font-mono text-lg font-bold ${timeLeft < 60 ? 'text-red-600 dark:text-red-400 animate-pulse' : 'text-gray-700 dark:text-gray-300'}`}>
              ⏱ {formatTime(timeLeft)}
            </span>
          )}
          {(!isExamMode && !isArcadeMode) && (
            <button onClick={handleFinishEarly} className="text-sm bg-gray-200 dark:bg-gray-700 hover:bg-gray-300 dark:hover:bg-gray-600 text-gray-800 dark:text-gray-200 px-3 py-1 rounded transition-colors">
              Finish Early
            </button>
          )}
          <button onClick={() => router.push('/')} className="text-gray-500 dark:text-gray-400 hover:text-red-600 font-medium transition-colors">✕ Exit</button>
        </div>
      </div>

      <p className="text-lg md:text-xl font-medium mb-8 text-gray-800 dark:text-gray-200">{currentQuestion.stem_text}</p>
      
      <div className="space-y-3 mb-8">
        {currentQuestion.choices.map((choice) => {
          let btnClass = "w-full text-left p-4 border rounded-lg transition-all duration-200 ";
          if (showResults) {
            if (choice.is_correct) btnClass += "bg-green-100 dark:bg-green-900/30 border-green-500 text-green-900 dark:text-green-100"; 
            else if (currentSelectedAnswer === choice.id) btnClass += "bg-red-100 dark:bg-red-900/30 border-red-500 text-red-900 dark:text-red-100"; 
            else btnClass += "bg-gray-50 dark:bg-gray-700/50 border-gray-200 dark:border-gray-600 text-gray-500"; 
          } else {
            btnClass += currentSelectedAnswer === choice.id ? "bg-blue-50 dark:bg-blue-900/40 border-blue-500 text-blue-900 dark:text-blue-100" : "bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-700 dark:text-gray-200";
          }
          return (
            <button key={choice.id} onClick={() => handleSelectAnswer(choice.id)} className={btnClass} disabled={showResults}>
              {choice.choice_text}
            </button>
          );
        })}
      </div>

      {showResults && (
        <div className="bg-blue-50 dark:bg-blue-900/20 p-5 rounded-lg mb-8 border border-blue-200 dark:border-blue-800">
          <p className="font-bold text-blue-800 dark:text-blue-300 mb-2">Explanation:</p>
          <p className="text-blue-900 dark:text-blue-100">{currentQuestion.explanation_text}</p>
        </div>
      )}

      <div className="flex justify-end mt-6">
        {isReviewMode ? (
          <button onClick={handleNext} className="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition-colors">Next Missed</button>
        ) : isExamMode ? (
          <button onClick={handleNext} disabled={!currentSelectedAnswer} className="bg-blue-600 text-white px-6 py-2 rounded-lg disabled:opacity-50 hover:bg-blue-700 transition-colors">Next Question</button>
        ) : !checkedQuestions[activeIndex] ? (
          <button onClick={handleCheckAnswer} disabled={!currentSelectedAnswer} className="bg-blue-600 text-white px-6 py-2 rounded-lg disabled:opacity-50 hover:bg-blue-700 transition-colors">Check Answer</button>
        ) : (
          <button onClick={handleNext} className="bg-green-600 text-white px-6 py-2 rounded-lg hover:bg-green-700 transition-colors">Next Question</button>
        )}
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
