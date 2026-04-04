'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

// Define the blueprint for the history data
interface TestHistory {
  name: string;
  score: number;
  exam: string;
  date: string;
}

export default function ProfilePage() {
  const { data: session, status } = useSession();
  const [history, setHistory] = useState<TestHistory[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    if (session?.user?.email) {
      fetch(`/api/gamify/history/${session.user.email}`)
        .then(res => res.json())
        .then(data => {
          if (data.success) {
            const formattedData: TestHistory[] = data.history.map((test: any, index: number) => ({
              name: `Test ${index + 1}`,
              score: test.score_percentage,
              exam: test.exam_code,
              date: new Date(test.created_at).toLocaleDateString()
            }));
            setHistory(formattedData);
          }
          setLoading(false);
        });
    }
  }, [session]);

  if (status === 'loading' || loading) return <div className="p-8 text-center">Loading Profile...</div>;
  if (!session) return <div className="p-8 text-center">Please sign in to view your profile.</div>;

  const hasPerfectScore = history.some(h => h.score === 100);
  const testsTaken = history.length;
  const isVeteran = testsTaken >= 10;

  return (
    <div className="max-w-4xl mx-auto p-8 text-black">
      <div className="flex justify-between items-center mb-8 border-b pb-4">
        <h1 className="text-3xl font-bold text-blue-800">{session.user?.name}'s Profile</h1>
        <Link href="/" className="text-blue-600 hover:underline font-medium">← Home</Link>
      </div>

      <h2 className="text-xl font-bold mb-4">Your Achievements</h2>
      <div className="flex gap-4 mb-10">
        <div className={`p-4 rounded-lg border text-center w-32 ${testsTaken > 0 ? 'bg-blue-50 border-blue-200' : 'bg-gray-50 opacity-50'}`}>
          <div className="text-3xl mb-2">👶</div>
          <div className="text-xs font-bold">First Test</div>
        </div>
        <div className={`p-4 rounded-lg border text-center w-32 ${hasPerfectScore ? 'bg-yellow-50 border-yellow-400' : 'bg-gray-50 opacity-50'}`}>
          <div className="text-3xl mb-2">🏆</div>
          <div className="text-xs font-bold">Perfect Score</div>
        </div>
        <div className={`p-4 rounded-lg border text-center w-32 ${isVeteran ? 'bg-purple-50 border-purple-300' : 'bg-gray-50 opacity-50'}`}>
          <div className="text-3xl mb-2">⭐</div>
          <div className="text-xs font-bold">10+ Exams</div>
        </div>
      </div>

      <h2 className="text-xl font-bold mb-4">Score Progression</h2>
      {history.length > 0 ? (
        <div className="h-72 bg-white p-4 rounded-lg shadow-sm border">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={history}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis domain={[0, 100]} />
              <Tooltip content={({ active, payload }) => {
                if (active && payload && payload.length) {
                  const data = payload[0].payload;
                  return (
                    <div className="bg-white p-2 border shadow-sm text-sm">
                      <p className="font-bold">ASE {data.exam}</p>
                      <p>Score: {data.score}%</p>
                      <p className="text-gray-500">{data.date}</p>
                    </div>
                  );
                }
                return null;
              }} />
              <Line type="monotone" dataKey="score" stroke="#2563eb" strokeWidth={3} activeDot={{ r: 8 }} />
            </LineChart>
          </ResponsiveContainer>
        </div>
      ) : (
        <p className="text-gray-500 italic">Take an exam to see your progress chart!</p>
      )}
    </div>
  );
}