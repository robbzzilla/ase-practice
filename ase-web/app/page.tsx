'use client';
import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useSession, signIn, signOut } from 'next-auth/react';

interface Exam {
  code: string;
  title: string;
}

interface TopicStat {
  correct: number;
  total: number;
}

export default function Home() {
  const { data: session, status } = useSession();
  const [expandedExam, setExpandedExam] = useState<string | null>(null);
  
  const [highScores, setHighScores] = useState<Record<string, number>>({});
  const [topicStats, setTopicStats] = useState<Record<string, Record<string, TopicStat>>>({});

  useEffect(() => {
    const loadData = async () => {
      if (session?.user?.email) {
        try {
          const res = await fetch(`/api/scores/${session.user.email}`);
          const data = await res.json();
          
          if (data.success && data.results) {
            const dbHighScores: Record<string, number> = {};
            const dbTopicStats: Record<string, Record<string, TopicStat>> = {};

            data.results.forEach((result: any) => {
              if (result.mode === 'Exam') {
                if (!dbHighScores[result.exam_code] || result.score_percentage > dbHighScores[result.exam_code]) {
                  dbHighScores[result.exam_code] = result.score_percentage;
                }

                if (result.topic_data) {
                  if (!dbTopicStats[result.exam_code]) dbTopicStats[result.exam_code] = {};
                  
                  Object.entries(result.topic_data).forEach(([topic, stats]: [string, any]) => {
                    if (!dbTopicStats[result.exam_code][topic]) {
                      dbTopicStats[result.exam_code][topic] = { correct: 0, total: 0 };
                    }
                    dbTopicStats[result.exam_code][topic].correct += stats.correct;
                    dbTopicStats[result.exam_code][topic].total += stats.total;
                  });
                }
              }
            });

            setHighScores(dbHighScores);
            setTopicStats(dbTopicStats);
          }
        } catch (err) {
          console.error("Failed to fetch synced scores:", err);
        }
      } else if (status !== 'loading') {
        const localScores = localStorage.getItem('ase_highscores');
        if (localScores) setHighScores(JSON.parse(localScores));

        const localTopics = localStorage.getItem('ase_topics');
        if (localTopics) setTopicStats(JSON.parse(localTopics));
      }
    };

    loadData();
  }, [session, status]);

  const exams: Exam[] = [
    { code: 'A1', title: 'Engine Repair' },
    { code: 'A2', title: 'Automatic Transmission/Transaxle' },
    { code: 'A3', title: 'Manual Drive Train & Axles' },
    { code: 'A4', title: 'Suspension & Steering' },
    { code: 'A5', title: 'Brakes' },
    { code: 'A6', title: 'Electrical/Electronic Systems' },
    { code: 'A7', title: 'Heating & Air Conditioning' },
    { code: 'A8', title: 'Engine Performance' },
  ];

  const toggleExpand = (code: string) => {
    if (expandedExam === code) {
      setExpandedExam(null);
    } else {
      setExpandedExam(code);
    }
  };

  return (
    <div className="max-w-5xl mx-auto p-4 md:p-8 text-black dark:text-white transition-colors">
      
      <div className="flex flex-wrap justify-end items-center gap-4 mb-8 text-sm">
        <Link href="/leaderboard" className="text-yellow-600 dark:text-yellow-500 hover:underline font-bold flex items-center gap-1">
          🏆 Leaderboard
        </Link>
        <span className="text-gray-300 dark:text-gray-600">|</span>
        {session ? (
          <>
            <Link href="/profile" className="font-medium text-gray-700 dark:text-gray-300 hover:underline">
              {session.user?.name || 'User'}
            </Link>
            {session.user?.email === 'rob.hampton93@gmail.com' && (
              <>
                <span className="text-gray-300 dark:text-gray-600">|</span>
                <Link href="/admin" className="text-purple-600 dark:text-purple-400 hover:underline font-bold">
                  Admin
                </Link>
              </>
            )}
            <span className="text-gray-300 dark:text-gray-600">|</span>
            <button onClick={() => signOut()} className="text-red-600 dark:text-red-400 hover:underline font-bold">Sign Out</button>
          </>
        ) : (
          <button onClick={() => signIn('google')} className="text-blue-600 dark:text-blue-400 hover:underline font-bold">
            Sign in with Google
          </button>
        )}
      </div>

      <h1 className="text-3xl md:text-4xl font-bold mb-2 text-center">ASE Practice Platform</h1>
      <p className="text-center text-gray-600 dark:text-gray-400 mb-10 text-sm md:text-base">Tap a certification area to view your stats and begin.</p>
      
      <div className="space-y-4 mb-12">
        {exams.map((exam) => {
          const bestScore = highScores[exam.code];
          const isExpanded = expandedExam === exam.code;
          
          const examTopics = topicStats[exam.code] || {};
          const topicEntries = Object.entries(examTopics)
            .map(([topic, stats]) => {
              const percentage = Math.round((stats.correct / stats.total) * 100);
              return { topic, percentage, correct: stats.correct, total: stats.total };
            })
            .sort((a, b) => b.percentage - a.percentage);

          const strengths = topicEntries.filter(t => t.percentage >= 80);
          const weaknesses = topicEntries.filter(t => t.percentage < 80);

          return (
            <div key={exam.code} className="border dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-gray-800 overflow-hidden transition-all">
              
              <div onClick={() => toggleExpand(exam.code)} className="p-4 md:p-6 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700 flex justify-between items-center relative transition-colors">
                {bestScore !== undefined && (
                  <div className={`absolute top-0 right-0 px-3 py-1 text-xs font-bold text-white rounded-bl-lg ${bestScore >= 80 ? 'bg-green-500 dark:bg-green-600' : 'bg-yellow-500 dark:bg-yellow-600'}`}>
                    Best: {bestScore}%
                  </div>
                )}
                <div className="pr-8">
                  <h2 className="text-lg md:text-xl font-bold text-blue-700 dark:text-blue-400">{exam.code}</h2>
                  <p className="text-gray-700 dark:text-gray-300 font-medium text-sm md:text-base">{exam.title}</p>
                </div>
                <div className="text-gray-400 dark:text-gray-500 text-xl md:text-2xl shrink-0">{isExpanded ? '▲' : '▼'}</div>
              </div>

              {isExpanded && (
                <div className="p-4 md:p-6 border-t dark:border-gray-700 bg-gray-50 dark:bg-gray-900/50 transition-colors">
                  <div className="flex flex-col sm:flex-row gap-3 md:gap-4 mb-8">
                    <Link href={`/test/${exam.code}?mode=practice`} className="flex-1 text-center px-4 py-3 bg-blue-600 dark:bg-blue-500 text-white rounded-lg hover:bg-blue-700 dark:hover:bg-blue-600 font-bold transition-colors shadow-sm">
                      Start Practice Mode
                    </Link>
                    <Link href={`/test/${exam.code}?mode=exam`} className="flex-1 text-center px-4 py-3 bg-purple-600 dark:bg-purple-500 text-white rounded-lg hover:bg-purple-700 dark:hover:bg-purple-600 font-bold transition-colors shadow-sm">
                      Start Exam Mode
                    </Link>
                  </div>

                  <h3 className="text-base md:text-lg font-bold text-gray-800 dark:text-gray-200 mb-4 border-b dark:border-gray-700 pb-2">Category Breakdown</h3>
                  
                  {topicEntries.length === 0 ? (
                    <p className="text-gray-500 dark:text-gray-400 italic text-sm">Complete a practice test to see your strengths and weaknesses here!</p>
                  ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                      
                      <div>
                        <h4 className="text-xs md:text-sm font-bold text-green-700 dark:text-green-400 mb-2 uppercase tracking-wider">Top Strengths</h4>
                        <ul className="space-y-2">
                          {strengths.length > 0 ? strengths.map(s => (
                            <li key={s.topic} className="flex justify-between items-center bg-white dark:bg-gray-800 p-2 md:p-3 rounded border border-green-200 dark:border-green-900/50 shadow-sm transition-colors">
                              <span className="text-xs md:text-sm font-medium text-gray-700 dark:text-gray-300 truncate mr-2" title={s.topic}>{s.topic}</span>
                              <span className="font-bold text-green-600 dark:text-green-400 text-sm">{s.percentage}%</span>
                            </li>
                          )) : <li className="text-gray-400 dark:text-gray-500 text-xs italic">Score 80% or higher in a category.</li>}
                        </ul>
                      </div>

                      <div>
                        <h4 className="text-xs md:text-sm font-bold text-red-700 dark:text-red-400 mb-2 uppercase tracking-wider">Areas to Review</h4>
                        <ul className="space-y-2">
                          {weaknesses.length > 0 ? weaknesses.map(w => (
                            <li key={w.topic} className="flex justify-between items-center bg-white dark:bg-gray-800 p-2 md:p-3 rounded border border-red-200 dark:border-red-900/50 shadow-sm transition-colors">
                              <div className="flex flex-col overflow-hidden mr-2">
                                <span className="text-xs md:text-sm font-medium text-gray-700 dark:text-gray-300 truncate" title={w.topic}>{w.topic}</span>
                              </div>
                              <div className="flex items-center gap-2 md:gap-3 shrink-0">
                                <span className="font-bold text-red-600 dark:text-red-400 text-sm">{w.percentage}%</span>
                                <Link href={`/test/${exam.code}?mode=practice&topic=${encodeURIComponent(w.topic)}`} className="bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400 hover:bg-red-200 dark:hover:bg-red-900/50 px-2 py-1 rounded text-xs font-bold transition-colors border dark:border-red-800">
                                  Practice
                                </Link>
                              </div>
                            </li>
                          )) : <li className="text-gray-400 dark:text-gray-500 text-xs italic">No areas need improvement!</li>}
                        </ul>
                      </div>

                    </div>
                  )}
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
