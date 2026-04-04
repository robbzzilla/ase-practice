'use client';
import { useState, useEffect } from 'react';
import Link from 'next/link';

interface LeaderboardEntry {
  id: number;
  score_percentage: number;
  exam_code: string;
  user: {
    username: string;
  };
}

export default function LeaderboardPage() {
  const [leaders, setLeaders] = useState<LeaderboardEntry[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

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
        setError("Failed to load leaderboard. Make sure the backend API is deployed!");
        setLoading(false);
      });
  }, []);

  if (loading) return <div className="p-8 text-center">Loading Global Rankings...</div>;
  if (error) return <div className="p-8 text-center text-red-600 font-bold">{error}</div>;

  return (
    <div className="max-w-3xl mx-auto p-8 text-black">
      <div className="flex justify-between items-center mb-8 border-b pb-4">
        <h1 className="text-3xl font-bold text-blue-800">Global Leaderboard</h1>
        <Link href="/" className="text-blue-600 hover:underline font-medium">← Home</Link>
      </div>

      <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
        <table className="w-full text-left">
          <thead className="bg-gray-50 border-b">
            <tr>
              <th className="p-4 font-bold text-gray-600">Rank</th>
              <th className="p-4 font-bold text-gray-600">User</th>
              <th className="p-4 font-bold text-gray-600">Exam</th>
              <th className="p-4 font-bold text-gray-600">Score</th>
            </tr>
          </thead>
          <tbody>
            {leaders.map((entry, index) => (
              <tr key={entry.id} className="border-b last:border-0 hover:bg-gray-50">
                <td className="p-4 font-bold text-gray-500">
                  {index === 0 ? '🥇 1st' : index === 1 ? '🥈 2nd' : index === 2 ? '🥉 3rd' : `#${index + 1}`}
                </td>
                <td className="p-4 font-medium">{entry.user.username.split('@')[0]}</td>
                <td className="p-4 text-blue-600 font-bold">ASE {entry.exam_code}</td>
                <td className="p-4 font-bold text-green-600">{entry.score_percentage}%</td>
              </tr>
            ))}
            {leaders.length === 0 && (
              <tr><td colSpan={4} className="p-4 text-center text-gray-500">No exams taken yet. Be the first!</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}