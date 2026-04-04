'use client';
import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useSession } from 'next-auth/react';

interface LeaderboardEntry {
  id: number;
  score_percentage: number;
  exam_code: string;
  user: {
    username: string;
    displayName?: string;
    shopName?: string;
    isPublic: boolean;
  };
}

export default function LeaderboardPage() {
  const { data: session } = useSession();
  const [leaders, setLeaders] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedExam, setSelectedExam] = useState('Overall');

  const tabs = ['Overall', 'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'];

  useEffect(() => {
    fetch('/api/gamify/leaderboard')
      .then(res => {
        if (!res.ok) throw new Error('Server returned an error');
        return res.json();
      })
      .then(data => {
        if (data.success) setLeaders(data.leaderboard);
        setLoading(false);
      })
      .catch(err => {
        console.error("Fetch error:", err);
        setError("Failed to load leaderboard.");
        setLoading(false);
      });
  }, []);

  const currentUserEmail = session?.user?.email || '';

  // 1. Filter by Exam
  const examFilteredData = selectedExam === 'Overall'
    ? [...leaders].sort((a, b) => b.score_percentage - a.score_percentage)
    : leaders.filter(entry => entry.exam_code === selectedExam).sort((a, b) => b.score_percentage - a.score_percentage);

  // 2. Filter out private users (but keep the current user so they can see their own rank)
  const publicData = examFilteredData.filter(entry => entry.user.isPublic !== false || entry.user.username === currentUserEmail);

  // 3. Find current user's rank
  const currentUserIndex = publicData.findIndex(entry => entry.user.username === currentUserEmail);
  const currentUserEntry = currentUserIndex !== -1 ? publicData[currentUserIndex] : null;
  const currentUserRank = currentUserIndex !== -1 ? currentUserIndex + 1 : null;

  // 4. Top 10 for main display
  const top10Data = publicData.slice(0, 10);
  const isUserInTop10 = currentUserRank !== null && currentUserRank <= 10;

  if (loading) return <div className="p-8 text-center dark:text-gray-200">Loading Global Rankings...</div>;
  if (error) return <div className="p-8 text-center text-red-600 dark:text-red-400 font-bold">{error}</div>;

  return (
    <div className="max-w-4xl mx-auto p-4 md:p-8 text-black dark:text-white transition-colors">
      <div className="flex justify-between items-center mb-8 border-b dark:border-gray-700 pb-4">
        <h1 className="text-2xl md:text-3xl font-bold text-blue-800 dark:text-blue-400">Global Leaderboard</h1>
        <Link href="/" className="text-blue-600 dark:text-blue-400 hover:underline font-medium">← Home</Link>
      </div>

      <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border dark:border-gray-700 overflow-hidden transition-colors p-4 md:p-6">
        <div className="flex overflow-x-auto gap-2 mb-6 pb-2 scrollbar-hide">
          {tabs.map(tab => (
            <button 
              key={tab}
              onClick={() => setSelectedExam(tab)}
              className={`px-4 py-2 rounded-full whitespace-nowrap font-medium transition-colors ${
                selectedExam === tab 
                  ? 'bg-blue-600 text-white' 
                  : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'
              }`}
            >
              {tab}
            </button>
          ))}
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-gray-50 dark:bg-gray-900/50 border-b dark:border-gray-700">
              <tr>
                <th className="p-4 font-bold text-gray-600 dark:text-gray-400">Rank</th>
                <th className="p-4 font-bold text-gray-600 dark:text-gray-400">Technician</th>
                {selectedExam === 'Overall' && <th className="p-4 font-bold text-gray-600 dark:text-gray-400">Exam</th>}
                <th className="p-4 font-bold text-gray-600 dark:text-gray-400">Score</th>
              </tr>
            </thead>
            <tbody>
              {top10Data.map((entry, index) => {
                const isCurrentUser = entry.user.username === currentUserEmail;
                const displayName = entry.user.displayName || entry.user.username.split('@')[0];
                
                return (
                  <tr key={entry.id} className={`border-b dark:border-gray-700/50 last:border-0 transition-colors ${isCurrentUser ? 'bg-blue-50 dark:bg-blue-900/20' : 'hover:bg-gray-50 dark:hover:bg-gray-700/25'}`}>
                    <td className="p-4 font-bold text-gray-500 dark:text-gray-400">
                      {index === 0 ? '🥇 1st' : index === 1 ? '🥈 2nd' : index === 2 ? '🥉 3rd' : `#${index + 1}`}
                    </td>
                    <td className="p-4 max-w-[150px] md:max-w-xs truncate">
                      <div className="font-bold text-gray-900 dark:text-gray-100">
                        {displayName} {isCurrentUser && <span className="text-blue-600 dark:text-blue-400 text-xs ml-1">(You)</span>}
                      </div>
                      {entry.user.shopName && (
                        <div className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">{entry.user.shopName}</div>
                      )}
                    </td>
                    {selectedExam === 'Overall' && (
                      <td className="p-4 text-blue-600 dark:text-blue-400 font-bold">ASE {entry.exam_code}</td>
                    )}
                    <td className="p-4 font-bold text-green-600 dark:text-green-400">{entry.score_percentage}%</td>
                  </tr>
                );
              })}

              {currentUserEntry && !isUserInTop10 && (
                <>
                  <tr><td colSpan={selectedExam === 'Overall' ? 4 : 3} className="p-2 text-center text-gray-400 dark:text-gray-500">• • •</td></tr>
                  <tr className="bg-blue-50/50 dark:bg-blue-900/10 italic border-t-2 border-blue-200 dark:border-blue-800">
                    <td className="p-4 font-bold text-gray-500 dark:text-gray-400">#{currentUserRank}</td>
                    <td className="p-4 max-w-[150px] md:max-w-xs truncate">
                      <div className="font-bold text-gray-900 dark:text-gray-100">
                        {currentUserEntry.user.displayName || currentUserEntry.user.username.split('@')[0]} <span className="text-blue-600 dark:text-blue-400 text-xs ml-1">(You)</span>
                      </div>
                      {currentUserEntry.user.shopName && <div className="text-xs text-gray-500 dark:text-gray-400 mt-0.5">{currentUserEntry.user.shopName}</div>}
                    </td>
                    {selectedExam === 'Overall' && <td className="p-4 text-blue-600 dark:text-blue-400 font-bold">ASE {currentUserEntry.exam_code}</td>}
                    <td className="p-4 font-bold text-green-600 dark:text-green-400">{currentUserEntry.score_percentage}%</td>
                  </tr>
                </>
              )}

              {publicData.length === 0 && (
                <tr><td colSpan={selectedExam === 'Overall' ? 4 : 3} className="p-8 text-center text-gray-500 dark:text-gray-400 italic">No public scores recorded yet.</td></tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}