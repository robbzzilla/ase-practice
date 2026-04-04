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
  const { data: session } = useSession();
  const [expandedExam, setExpandedExam] = useState<string | null>(null);
  
  const [highScores, setHighScores] = useState<Record<string, number>>({});
  const [topicStats, setTopicStats] = useState<Record<string, Record<string, TopicStat>>>({});

  useEffect(() => {
    const scores = localStorage.getItem('ase_highscores');
    if (scores) setHighScores(JSON.parse(scores));

    const topics = localStorage.getItem('ase_topics');
    if (topics) setTopicStats(JSON.parse(topics));
  }, []);

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
    <div className="max-w-4xl mx-auto p-8 text-black relative">
      
      {/* Auth Header */}
      <div className="absolute top-4 right-8 flex items-center gap-4 bg-gray-50 px-4 py-2 rounded-full border shadow-sm">
        {session ? (
          <>
            <span className="font-medium text-gray-700 text-sm">Welcome, {session.user?.name || 'User'}!</span>
            {session.user?.email === 'rob.hampton93@gmail.com' && (
              <Link href="/admin" className="text-sm text-purple-600 hover:underline font-bold border-l border-r px-3 border-gray-300">
                Admin Panel
              </Link>
            )}
            <button onClick={() => signOut()} className="text-sm text-red-600 hover:underline font-bold">Sign Out</button>
          </>
        ) : (
          <button onClick={() => signIn('google')} className="text-sm text-blue-600 hover:underline font-bold">
            Sign in with Google
          </button>
        )}
      </div>

      <h1 className="text-4xl font-bold mb-2 text-center mt-12">ASE Practice Platform</h1>
      <p className="text-center text-gray-600 mb-10">Tap a certification area to view your stats and begin.</p>
      
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
            <div key={exam.code} className="border rounded-lg shadow-sm bg-white overflow-hidden transition-all">
              
              {/* Clickable Header */}
              <div onClick={() => toggleExpand(exam.code)} className="p-6 cursor-pointer hover:bg-gray-50 flex justify-between items-center relative">
                {bestScore !== undefined && (
                  <div className={`absolute top-0 right-0 px-3 py-1 text-xs font-bold text-white rounded-bl-lg ${bestScore >= 80 ? 'bg-green-500' : 'bg-yellow-500'}`}>
                    Best: {bestScore}%
                  </div>
                )}
                <div>
                  <h2 className="text-xl font-bold text-blue-700">{exam.code}</h2>
                  <p className="text-gray-700 font-medium">{exam.title}</p>
                </div>
                <div className="text-gray-400 text-2xl">{isExpanded ? '▲' : '▼'}</div>
              </div>

              {/* Expanded Content */}
              {isExpanded && (
                <div className="p-6 border-t bg-gray-50">
                  <div className="flex gap-4 mb-8">
                    <Link href={`/test/${exam.code}?mode=practice`} className="flex-1 text-center px-4 py-3 bg-blue-600 text-white rounded hover:bg-blue-700 font-bold transition-colors shadow-sm">
                      Start Practice Mode
                    </Link>
                    <Link href={`/test/${exam.code}?mode=exam`} className="flex-1 text-center px-4 py-3 bg-purple-600 text-white rounded hover:bg-purple-700 font-bold transition-colors shadow-sm">
                      Start Exam Mode
                    </Link>
                  </div>

                  <h3 className="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Category Breakdown</h3>
                  
                  {topicEntries.length === 0 ? (
                    <p className="text-gray-500 italic text-sm">Complete a practice test to see your strengths and weaknesses here!</p>
                  ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                      
                      {/* Strengths */}
                      <div>
                        <h4 className="text-sm font-bold text-green-700 mb-2 uppercase tracking-wider">Top Strengths</h4>
                        <ul className="space-y-2">
                          {strengths.length > 0 ? strengths.map(s => (
                            <li key={s.topic} className="flex justify-between items-center bg-white p-2 rounded border border-green-200 shadow-sm">
                              <span className="text-sm font-medium text-gray-700 truncate mr-2" title={s.topic}>{s.topic}</span>
                              <span className="font-bold text-green-600 text-sm">{s.percentage}%</span>
                            </li>
                          )) : <li className="text-gray-400 text-xs italic">Score 80% or higher in a category.</li>}
                        </ul>
                      </div>

                      {/* Weaknesses */}
                      <div>
                        <h4 className="text-sm font-bold text-red-700 mb-2 uppercase tracking-wider">Areas to Review</h4>
                        <ul className="space-y-2">
                          {weaknesses.length > 0 ? weaknesses.map(w => (
                            <li key={w.topic} className="flex justify-between items-center bg-white p-2 rounded border border-red-200 shadow-sm">
                              <div className="flex flex-col overflow-hidden mr-2">
                                <span className="text-sm font-medium text-gray-700 truncate" title={w.topic}>{w.topic}</span>
                              </div>
                              <div className="flex items-center gap-3 shrink-0">
                                <span className="font-bold text-red-600 text-sm">{w.percentage}%</span>
                                <Link href={`/test/${exam.code}?mode=practice&topic=${encodeURIComponent(w.topic)}`} className="bg-red-100 text-red-700 hover:bg-red-200 px-2 py-1 rounded text-xs font-bold transition-colors">
                                  Practice
                                </Link>
                              </div>
                            </li>
                          )) : <li className="text-gray-400 text-xs italic">No areas need improvement!</li>}
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