'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';

export default function AdminDashboard() {
  const { data: session, status } = useSession();
  const router = useRouter();
  const [stats, setStats] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (status === 'loading') return;
    
    // Security Check: Kick out anyone who isn't the admin
    if (session?.user?.email !== 'rob.hampton93@gmail.com') {
      router.push('/');
      return;
    }

    fetch('/api/admin/stats')
      .then(res => res.json())
      .then(data => {
        if (data.success) setStats(data.stats);
        setLoading(false);
      })
      .catch(err => {
        console.error(err);
        setLoading(false);
      });
  }, [session, status, router]);

  if (loading) return <div className="p-8 text-center dark:text-white">Loading Admin Dashboard...</div>;

  return (
    <div className="max-w-6xl mx-auto p-4 md:p-8 text-black dark:text-white transition-colors">
      <div className="flex justify-between items-center mb-8 border-b dark:border-gray-700 pb-4">
        <h1 className="text-3xl font-bold text-purple-700 dark:text-purple-400">Admin Dashboard</h1>
        <Link href="/" className="text-blue-600 dark:text-blue-400 hover:underline font-medium">← Home</Link>
      </div>

      {/* High-Level Metric Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700 transition-colors">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Total Users</h3>
          <p className="text-4xl font-bold text-gray-900 dark:text-white mt-2">{stats?.totalUsers || 0}</p>
        </div>
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700 transition-colors">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Exams Completed</h3>
          <p className="text-4xl font-bold text-blue-600 dark:text-blue-400 mt-2">{stats?.totalExams || 0}</p>
        </div>
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700 transition-colors">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Platform Avg Score</h3>
          <p className="text-4xl font-bold text-green-600 dark:text-green-400 mt-2">{stats?.averageScore || 0}%</p>
        </div>
      </div>

      {/* Recent Activity Table */}
      <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border dark:border-gray-700 overflow-hidden transition-colors">
        <div className="p-6 border-b dark:border-gray-700">
          <h2 className="text-xl font-bold dark:text-white">Recent Platform Activity</h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-gray-50 dark:bg-gray-900/50">
              <tr>
                <th className="p-4 font-semibold text-gray-600 dark:text-gray-400 border-b dark:border-gray-700">User</th>
                <th className="p-4 font-semibold text-gray-600 dark:text-gray-400 border-b dark:border-gray-700">Exam</th>
                <th className="p-4 font-semibold text-gray-600 dark:text-gray-400 border-b dark:border-gray-700">Mode</th>
                <th className="p-4 font-semibold text-gray-600 dark:text-gray-400 border-b dark:border-gray-700">Score</th>
                <th className="p-4 font-semibold text-gray-600 dark:text-gray-400 border-b dark:border-gray-700">Date</th>
              </tr>
            </thead>
            <tbody>
              {stats?.recentExams?.length > 0 ? (
                stats.recentExams.map((exam: any) => (
                  <tr key={exam.id} className="border-b dark:border-gray-700/50 last:border-0 hover:bg-gray-50 dark:hover:bg-gray-700/25 transition-colors">
                    <td className="p-4 font-medium max-w-[150px] truncate" title={exam.user.username}>
                      {exam.user.displayName || exam.user.username.split('@')[0]}
                    </td>
                    <td className="p-4 font-bold text-blue-600 dark:text-blue-400">ASE {exam.exam_code}</td>
                    <td className="p-4 text-gray-600 dark:text-gray-300">{exam.mode}</td>
                    <td className={`p-4 font-bold ${exam.score_percentage >= 70 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'}`}>
                      {exam.score_percentage}%
                    </td>
                    <td className="p-4 text-sm text-gray-500 dark:text-gray-400">
                      {new Date(exam.created_at).toLocaleDateString()}
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={5} className="p-8 text-center text-gray-500 dark:text-gray-400 italic">
                    No recent activity found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
