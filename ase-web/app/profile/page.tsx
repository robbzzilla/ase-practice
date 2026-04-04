'use client';
import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import Link from 'next/link';

export default function ProfilePage() {
  const { data: session, status } = useSession();
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [saveMessage, setSaveMessage] = useState('');

  // Form State
  const [displayName, setDisplayName] = useState('');
  const [shopName, setShopName] = useState('');
  const [isPublic, setIsPublic] = useState(true);

  useEffect(() => {
    if (session?.user?.email) {
      // Fetch Profile Settings
      fetch(`/api/gamify/profile/${session.user.email}`)
        .then(res => res.json())
        .then(data => {
          if (data.success && data.profile) {
            setDisplayName(data.profile.displayName || '');
            setShopName(data.profile.shopName || '');
            setIsPublic(data.profile.isPublic ?? true);
          }
        });

      // Fetch Exam History
      fetch(`/api/gamify/history/${session.user.email}`)
        .then(res => res.json())
        .then(data => {
          if (data.success) setHistory(data.history);
          setLoading(false);
        });
    }
  }, [session]);

  const handleSaveProfile = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);
    setSaveMessage(''); // Clear previous message
    
    try {
      const res = await fetch(`/api/gamify/profile/${session?.user?.email}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ displayName, shopName, isPublic })
      });
      if (res.ok) {
        setSaveMessage('Profile settings saved successfully!');
        // Hide the message after 4 seconds
        setTimeout(() => setSaveMessage(''), 4000);
      }
    } catch (err) {
      console.error(err);
    }
    setSaving(false);
  };

  if (status === 'loading' || loading) return <div className="p-8 text-center dark:text-white">Loading Profile...</div>;
  if (!session) return <div className="p-8 text-center dark:text-white">Please sign in to view your profile.</div>;

  return (
    <div className="max-w-4xl mx-auto p-4 md:p-8 text-black dark:text-white transition-colors">
      <div className="flex justify-between items-center mb-8 border-b dark:border-gray-700 pb-4">
        <h1 className="text-3xl font-bold text-blue-800 dark:text-blue-400">Your Profile</h1>
        <Link href="/" className="text-blue-600 dark:text-blue-400 hover:underline font-medium">← Home</Link>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
        
        {/* Left Column: Settings Form */}
        <div className="md:col-span-1 space-y-6">
          <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700">
            <h2 className="text-xl font-bold mb-4 dark:text-white">Profile Settings</h2>
            
            {/* Prominent Success Banner */}
            {saveMessage && (
              <div className="mb-6 p-3 bg-green-100 border border-green-400 text-green-700 dark:bg-green-900/30 dark:border-green-800 dark:text-green-400 rounded-lg flex items-center gap-2 transition-all">
                <svg className="w-5 h-5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"></path>
                </svg>
                <span className="font-medium text-sm">{saveMessage}</span>
              </div>
            )}

            <form onSubmit={handleSaveProfile} className="space-y-4">
              
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Display Name</label>
                <input 
                  type="text" 
                  value={displayName} 
                  onChange={(e) => setDisplayName(e.target.value)}
                  placeholder={session?.user?.name || 'Enter display name'}
                  className="w-full p-2 border dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 dark:text-white focus:ring-2 focus:ring-blue-500 outline-none transition-colors"
                />
                <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">This is how you will appear on the leaderboard.</p>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Shop / Dealership</label>
                <input 
                  type="text" 
                  value={shopName} 
                  onChange={(e) => setShopName(e.target.value)}
                  placeholder="e.g. Toyota of Seattle"
                  className="w-full p-2 border dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 dark:text-white focus:ring-2 focus:ring-blue-500 outline-none transition-colors"
                />
              </div>

              <div className="flex items-center gap-2 pt-2">
                <input 
                  type="checkbox" 
                  id="isPublic"
                  checked={isPublic}
                  onChange={(e) => setIsPublic(e.target.checked)}
                  className="w-4 h-4 text-blue-600 rounded focus:ring-blue-500"
                />
                <label htmlFor="isPublic" className="text-sm font-medium text-gray-700 dark:text-gray-300 cursor-pointer">
                  Show my scores on the public leaderboard
                </label>
              </div>

              <button 
                type="submit" 
                disabled={saving}
                className="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors disabled:opacity-50 mt-4"
              >
                {saving ? 'Saving...' : 'Save Settings'}
              </button>
            </form>
          </div>
        </div>

        {/* Right Column: Exam History */}
        <div className="md:col-span-2">
          <div className="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-sm border dark:border-gray-700">
            <h2 className="text-xl font-bold mb-4 dark:text-white">Recent Exam History</h2>
            
            {history.length === 0 ? (
              <p className="text-gray-500 dark:text-gray-400 italic">You haven't completed any exams yet.</p>
            ) : (
              <div className="space-y-3">
                {history.map((attempt: any) => (
                  <div key={attempt.id} className="flex justify-between items-center p-4 border dark:border-gray-700 rounded-lg bg-gray-50 dark:bg-gray-700/50 transition-colors">
                    <div>
                      <span className="font-bold text-blue-700 dark:text-blue-400 mr-3">ASE {attempt.exam_code}</span>
                      <span className="text-sm text-gray-600 dark:text-gray-300">{attempt.mode} Mode</span>
                    </div>
                    <div className={`font-bold text-lg ${attempt.score_percentage >= 70 ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'}`}>
                      {attempt.score_percentage}%
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

      </div>
    </div>
  );
}