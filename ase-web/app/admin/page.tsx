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
  
  // Manual Form State
  const [isFormOpen, setIsFormOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formData, setFormData] = useState({ examCode: 'A1', topic: '', difficulty: 'Medium', stemText: '', explanationText: '' });
  const [choices, setChoices] = useState([
    { text: '', isCorrect: true }, { text: '', isCorrect: false }, { text: '', isCorrect: false }, { text: '', isCorrect: false }
  ]);

  // AI Generator State
  const [isAIOpen, setIsAIOpen] = useState(false);
  const [isGenerating, setIsGenerating] = useState(false);
  const [aiConfig, setAiConfig] = useState({ examCode: 'A1', topic: '', count: 3 });
  const [generatedQuestions, setGeneratedQuestions] = useState<any[]>([]);

  const fetchCounts = async () => {
    try {
      const res = await fetch('/api/admin/question-counts');
      const data = await res.json();
      if (data.success) setQCounts(data.counts);
    } catch (err) { console.error(err); }
  };

  useEffect(() => {
    if (status === 'loading') return;
    if (session?.user?.email !== 'rob.hampton93@gmail.com') {
      router.push('/');
      return;
    }

    Promise.all([
      fetch('/api/admin/stats').then(res => res.json()),
      fetchCounts()
    ]).then(([statsData]) => {
      if (statsData.success) setStats(statsData.stats);
      setLoading(false);
    }).catch(err => {
      console.error(err);
      setLoading(false);
    });
  }, [session, status, router]);

  // Manual Form Handlers
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
        setFormData({ ...formData, stemText: '', explanationText: '', topic: '' });
        setChoices([{ text: '', isCorrect: true }, { text: '', isCorrect: false }, { text: '', isCorrect: false }, { text: '', isCorrect: false }]);
        fetchCounts();
      } else {
        toast.error('Failed to add question.');
      }
    } catch (err) { toast.error('An error occurred.'); }
    setIsSubmitting(false);
  };

  // AI Handlers
  const handleGenerateAI = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsGenerating(true);
    setGeneratedQuestions([]);
    const loadingToast = toast.loading('AI is writing questions...');
    
    try {
      const res = await fetch('/api/admin/generate-ai', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(aiConfig)
      });
      const data = await res.json();
      
      if (data.success) {
        setGeneratedQuestions(data.questions);
        toast.success('Questions generated successfully!', { id: loadingToast });
      } else {
        toast.error(data.error || 'Failed to generate.', { id: loadingToast });
      }
    } catch (err) {
      toast.error('Server error during generation.', { id: loadingToast });
    }
    setIsGenerating(false);
  };

  const saveAIQuestion = async (q: any, index: number) => {
    const payload = {
      examCode: aiConfig.examCode,
      topic: aiConfig.topic || 'General',
      difficulty: 'Medium',
      stemText: q.stemText,
      explanationText: q.explanationText,
      choices: q.choices
    };

    try {
      const res = await fetch('/api/admin/questions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
      });
      const data = await res.json();
      if (data.success) {
        toast.success('Saved to database!');
        setGeneratedQuestions(prev => prev.filter((_, i) => i !== index));
        fetchCounts();
      } else {
        toast.error('Failed to save.');
      }
    } catch (err) { toast.error('Error saving question.'); }
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
              {qCounts.length > 0 ? qCounts.map(q => (
                <div key={q.code} className="flex justify-between items-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded border dark:border-gray-600">
                  <span className="font-bold text-blue-700 dark:text-blue-400">ASE {q.code}</span>
                  <span className="font-medium text-gray-700 dark:text-gray-300">{q.count} Questions</span>
                </div>
              )) : <p className="text-sm text-gray-500">No questions found.</p>}
            </div>
          </div>
        </div>

        {/* Right Column: Forms */}
        <div className="lg:col-span-2 space-y-6">
          
          {/* AI Generator Form */}
          <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-blue-200 dark:border-blue-800 overflow-hidden">
            <div 
              className="p-6 border-b border-blue-100 dark:border-blue-900/50 flex justify-between items-center cursor-pointer hover:bg-blue-50 dark:hover:bg-blue-900/20 transition-colors"
              onClick={() => setIsAIOpen(!isAIOpen)}
            >
              <h2 className="text-xl font-bold text-blue-700 dark:text-blue-400">🤖 Generate AI Questions</h2>
              <span className="text-2xl text-blue-400">{isAIOpen ? '▲' : '▼'}</span>
            </div>
            
            {isAIOpen && (
              <div className="p-6 bg-blue-50/50 dark:bg-blue-900/10">
                <form onSubmit={handleGenerateAI} className="space-y-4 mb-6">
                  <div className="grid grid-cols-3 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Exam Area</label>
                      <select value={aiConfig.examCode} onChange={e => setAiConfig({...aiConfig, examCode: e.target.value})} className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white">
                        {['A1','A2','A3','A4','A5','A6','A7','A8'].map(code => <option key={code} value={code}>{code}</option>)}
                      </select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Topic Focus</label>
                      <input required type="text" value={aiConfig.topic} onChange={e => setAiConfig({...aiConfig, topic: e.target.value})} placeholder="e.g. Brakes" className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white" />
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Amount</label>
                      <input type="number" min="1" max="10" value={aiConfig.count} onChange={e => setAiConfig({...aiConfig, count: parseInt(e.target.value)})} className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white" />
                    </div>
                  </div>
                  <button type="submit" disabled={isGenerating} className="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded transition-colors disabled:opacity-50">
                    {isGenerating ? 'Generating...' : 'Generate Questions'}
                  </button>
                </form>

                {/* AI Preview Area - NOW EDITABLE */}
                {generatedQuestions.length > 0 && (
                  <div className="space-y-6 border-t border-blue-200 dark:border-blue-800 pt-6">
                    <h3 className="font-bold text-lg text-gray-800 dark:text-gray-200">Review, Edit & Approve</h3>
                    {generatedQuestions.map((q, index) => (
                      <div key={index} className="bg-white dark:bg-gray-800 p-4 rounded border dark:border-gray-600 shadow-sm space-y-4">
                        
                        {/* Editable Stem */}
                        <div>
                          <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Question Text</label>
                          <textarea 
                            className="w-full p-2 border dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 dark:text-white"
                            rows={2}
                            value={q.stemText}
                            onChange={(e) => {
                              const updated = [...generatedQuestions];
                              updated[index].stemText = e.target.value;
                              setGeneratedQuestions(updated);
                            }}
                          />
                        </div>

                        {/* Editable Choices */}
                        <div>
                          <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Choices (Select Correct)</label>
                          <div className="space-y-2">
                            {q.choices.map((c: any, i: number) => (
                              <div key={i} className="flex items-center gap-2">
                                <input 
                                  type="radio" 
                                  name={`correct-${index}`} 
                                  checked={c.isCorrect} 
                                  onChange={() => {
                                    const updated = [...generatedQuestions];
                                    updated[index].choices.forEach((choice: any, idx: number) => {
                                      choice.isCorrect = (idx === i);
                                    });
                                    setGeneratedQuestions(updated);
                                  }}
                                  className="w-4 h-4 text-blue-600"
                                />
                                <input 
                                  type="text"
                                  className={`w-full p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:text-white text-sm ${c.isCorrect ? 'border-green-500' : 'dark:border-gray-600'}`}
                                  value={c.text}
                                  onChange={(e) => {
                                    const updated = [...generatedQuestions];
                                    updated[index].choices[i].text = e.target.value;
                                    setGeneratedQuestions(updated);
                                  }}
                                />
                              </div>
                            ))}
                          </div>
                        </div>

                        {/* Editable Explanation */}
                        <div>
                          <label className="block text-xs font-bold text-gray-500 uppercase mb-1">Explanation</label>
                          <textarea 
                            className="w-full p-2 border dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 dark:text-white text-sm"
                            rows={2}
                            value={q.explanationText}
                            onChange={(e) => {
                              const updated = [...generatedQuestions];
                              updated[index].explanationText = e.target.value;
                              setGeneratedQuestions(updated);
                            }}
                          />
                        </div>

                        {/* Action Buttons */}
                        <div className="flex gap-3 pt-2">
                          <button onClick={() => saveAIQuestion(q, index)} className="flex-1 bg-green-600 hover:bg-green-700 text-white text-sm font-bold py-2 px-4 rounded transition-colors">
                            ✓ Approve & Save
                          </button>
                          <button onClick={() => setGeneratedQuestions(prev => prev.filter((_, i) => i !== index))} className="bg-red-100 text-red-700 hover:bg-red-200 dark:bg-red-900/30 dark:text-red-400 dark:hover:bg-red-900/50 text-sm font-bold py-2 px-4 rounded transition-colors">
                            ✕ Discard
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            )}
          </div>

          {/* Manual Add Question Form */}
          <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border dark:border-gray-700 overflow-hidden">
            <div 
              className="p-6 border-b dark:border-gray-700 flex justify-between items-center cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
              onClick={() => setIsFormOpen(!isFormOpen)}
            >
              <h2 className="text-xl font-bold dark:text-white">✍️ Manually Add Question</h2>
              <span className="text-2xl text-gray-400">{isFormOpen ? '▲' : '▼'}</span>
            </div>
            
            {isFormOpen && (
              <div className="p-6 bg-gray-50 dark:bg-gray-900/30">
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Exam Area</label>
                      <select value={formData.examCode} onChange={e => setFormData({...formData, examCode: e.target.value})} className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white">
                        {['A1','A2','A3','A4','A5','A6','A7','A8'].map(code => <option key={code} value={code}>{code}</option>)}
                      </select>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Topic / Category</label>
                      <input required type="text" value={formData.topic} onChange={e => setFormData({...formData, topic: e.target.value})} placeholder="e.g. Engine Block Diagnosis" className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white" />
                    </div>
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Question Text</label>
                    <textarea required rows={3} value={formData.stemText} onChange={e => setFormData({...formData, stemText: e.target.value})} className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white" />
                  </div>

                  <div>
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Explanation</label>
                    <textarea required rows={2} value={formData.explanationText} onChange={e => setFormData({...formData, explanationText: e.target.value})} className="w-full p-2 border dark:border-gray-600 rounded bg-white dark:bg-gray-700 dark:text-white" />
                  </div>

                  <div className="space-y-2 pt-2">
                    <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Answer Choices (Select the correct one)</label>
                    {choices.map((choice, index) => (
                      <div key={index} className="flex items-center gap-3">
                        <input type="radio" name="correctAnswer" checked={choice.isCorrect} onChange={() => handleCorrectChange(index)} className="w-5 h-5 text-blue-600" />
                        <input required type="text" value={choice.text} onChange={e => handleChoiceChange(index, e.target.value)} placeholder={`Choice ${index + 1}`} className={`w-full p-2 border rounded bg-white dark:bg-gray-700 dark:text-white ${choice.isCorrect ? 'border-green-500 ring-1 ring-green-500' : 'dark:border-gray-600'}`} />
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
    </div>
  );
}
