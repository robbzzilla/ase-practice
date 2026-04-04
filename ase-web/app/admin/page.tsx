'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import toast from 'react-hot-toast';

export default function AdminDashboard() {
  const { data: session, status } = useSession();
  const router = useRouter();
  
  const [stats, setStats] = useState<any>(null);
  const [qCounts, setQCounts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  
  // Form State
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formData, setFormData] = useState({
    examCode: 'A1',
    topic: '',
    difficulty: 'Medium',
    stemText: '',
    explanationText: '',
  });
  const [choices, setChoices] = useState([
    { text: '', isCorrect: true },
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
  ]);

  useEffect(() => {
    if (status === 'loading') return;
    if (session?.user?.email !== 'rob.hampton93@gmail.com') {
      router.push('/');
      return;
    }

    Promise.all([
      fetch('/api/admin/stats').then(res => res.json()),
      fetch('/api/admin/question-counts').then(res => res.json())
    ]).then(([statsData, countsData]) => {
      if (statsData.success) setStats(statsData.stats);
      if (countsData.success) setQCounts(countsData.counts);
      setLoading(false);
    }).catch(err => {
      console.error(err);
      setLoading(false);
    });
  }, [session, status, router]);

  const handleChoiceChange = (index: number, text: string) => {
    const newChoices = [...choices];
    newChoices[index].text = text;
    setChoices(newChoices);
  };

  const handleCorrectChange = (index: number) => {
    const newChoices = choices.map((c, i) => ({ ...c, isCorrect: i === index }));
    setChoices(newChoices);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    try {
      const res = await fetch('/api/admin/questions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ...formData, choices })
      });
      
      const data = await res.json();
      if (data.success) {
        toast.success('Question added to database!');
        // Reset form
        setFormData({ ...formData, stemText: '', explanationText: '', topic: '' });
        setChoices([{ text: '', isCorrect: true }, { text: '', isCorrect: false }, { text: '', isCorrect: false }, { text: '', isCorrect: false }]);
        // Refresh counts
        const countsRes = await fetch('/api/admin/question-counts');
        const countsData = await countsRes.json();
        if (countsData.success) setQCounts(countsData.counts);
      } else {
        toast.error('Failed to add question.');
      }
    } catch (err) {
      toast.error('An error occurred.');
    }
    setIsSubmitting(false);
  };

  if (loading) return <div className="p-8 text-center dark:text-white">Loading Admin Dashboard...</div>;

  return (
    <div className="max-w-6xl mx-auto p-4 md:p-8 text-black dark:text-white transition-colors">
      <div className="flex justify-between items-center mb-8 border-b dark:border-gray-700 pb-4">
        <h1 className="text-3xl font-bold text-purple-700 dark:text-purple-400">Admin Dashboard</h1>
        <Link href="/" className="text-blue-600 dark:text-blue-400 hover:underline font-medium">← Home</Link>
      </div>

      {/* High-Level Metric Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Total Users</h3>
          <p className="text-4xl font-bold text-gray-900 dark:text-white mt-2">{stats?.totalUsers || 0}</p>
        </div>
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Exams Completed</h3>
          <p className="text-4xl font-bold text-blue-600 dark:text-blue-400 mt-2">{stats?.totalExams || 0}</p>
        </div>
        <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700">
          <h3 className="text-gray-500 dark:text-gray-400 font-medium uppercase tracking-wider text-sm">Platform Avg Score</h3>
          <p className="text-4xl font-bold text-green-600 dark:text-green-400 mt-2">{stats?.averageScore || 0}%</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8">
        
        {/* Left Column: Question Bank Status */}
        <div className="lg:col-span-1">
          <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border dark:border-gray-700 p-6">
            <h2 className="text-xl font-bold dark:text-white mb-4">Question Bank Status</h2>
            <div className="space-y-3">
              {qCounts.map(q => (
                <div key={q.code} className="flex justify-between items-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded border dark:border-gray-600">
                  <span className="font-bold text-blue-700 dark:text-blue-400">ASE {q.code}</span>
                  <span className="font-medium text-gray-700 dark:text-gray-300">{q.count} Questions</span>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Right Column: Expandable Add Question Form */}
        <div className="lg:col-span-2">
          <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border dark:border-gray-700 overflow-hidden">
            <div 
              className="p-6 border-b dark:border-gray-700 flex justify-between items-center cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
              onClick={() => setIsFormOpen(!isFormOpen)}
            >
              <h2 className="text-xl font-bold dark:text-white">➕ Add New Question</h2>
              <span className="text-2xl text-gray-400">{isFormOpen ? '▲' : '▼'}</span>
            </div>
            
            {isFormOpen && (
              <div className="p-6 bg-gray-50 dark:bg-gray-900/30">
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Exam Area</label>
                      <select 
                        value={formData.examCode} 
                        onChange={e => setFormData({...formData, examCode: e.target.value})}
                        className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white"
                      >
                        {['A1','A2','A3','A4','A5','A6','A7','A8'].map(code => <option key={code} value={code}>{code}</option>)}
                      </select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Topic / Category</label>
                      <input 
                        required type="text" value={formData.topic} onChange={e => setFormData({...formData, topic: e.target.value})}
                        placeholder="e.g. Engine Block Diagnosis"
                        className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white"
                      />
                    </div>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Question Text</label>
                    <textarea 
                      required rows={3} value={formData.stemText} onChange={e => setFormData({...formData, stemText: e.target.value})}
                      className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Explanation (Shown in Study Mode)</label>
                    <textarea 
                      required rows={2} value={formData.explanationText} onChange={e => setFormData({...formData, explanationText: e.target.value})}
                      className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white"
                    />
                  </div>

                  <div className="space-y-2 pt-2">
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Answer Choices (Select the correct one)</label>
                    {choices.map((choice, index) => (
                      <div key={index} className="flex items-center gap-3">
                        <input 
                          type="radio" name="correctAnswer" checked={choice.isCorrect} onChange={() => handleCorrectChange(index)}
                          className="w-5 h-5 text-blue-600"
                        />
                        <input 
                          required type="text" value={choice.text} onChange={e => handleChoiceChange(index, e.target.value)}
                          placeholder={`Choice ${index + 1}`}
                          className={`w-full p-2 border rounded bg-white dark:bg-gray-700 dark:text-white ${choice.isCorrect ? 'border-green-500 ring-1 ring-green-500' : 'dark:border-gray-600'}`}
                        />
                      </div>
                    ))}
                  </div>

                  <button type="submit" disabled={isSubmitting} className="w-full mt-4 bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-4 rounded transition-colors disabled:opacity-50">
                    {isSubmitting ? 'Saving...' : 'Save Question to Database'}
                  </button>
                </form>
              </div>
            )}
          </div>
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
