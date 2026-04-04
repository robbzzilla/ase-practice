'use client';
import { useState } from 'react';
import { useSession } from 'next-auth/react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

// Define the blueprint for a multiple choice option
interface Choice {
  text: string;
  isCorrect: boolean;
}

const ADMIN_EMAIL = "rob.hampton93@gmail.com"; 

export default function AdminPage() {
  const { data: session, status } = useSession();
  const router = useRouter();

  const [examCode, setExamCode] = useState<string>('A1');
  const [topic, setTopic] = useState<string>('');
  const [stemText, setStemText] = useState<string>('');
  const [explanationText, setExplanationText] = useState<string>('');
  const [choices, setChoices] = useState<Choice[]>([
    { text: '', isCorrect: true }, 
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
    { text: '', isCorrect: false },
  ]);
  const [statusMsg, setStatusMsg] = useState<string>('');

  if (status === 'loading') return <div className="p-8 text-center">Loading...</div>;
  if (!session || session.user?.email !== ADMIN_EMAIL) {
    return (
      <div className="p-8 text-center text-red-600 mt-10">
        <h1 className="text-2xl font-bold">Access Denied</h1>
        <p>You do not have permission to view this page.</p>
        <Link href="/" className="text-blue-600 underline mt-4 block">Return Home</Link>
      </div>
    );
  }

  const handleChoiceChange = (index: number, text: string) => {
    const newChoices = [...choices];
    newChoices[index].text = text;
    setChoices(newChoices);
  };

  const handleCorrectChange = (index: number) => {
    const newChoices = choices.map((c, i) => ({
      ...c,
      isCorrect: i === index
    }));
    setChoices(newChoices);
  };

  // Add React.FormEvent type to the submit event
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setStatusMsg('Saving...');

    try {
      const res = await fetch('/api/admin/questions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ examCode, topic, stemText, explanationText, choices })
      });

      const data = await res.json();
      if (data.success) {
        setStatusMsg('Question added successfully!');
        setStemText('');
        setExplanationText('');
        setChoices([
          { text: '', isCorrect: true },
          { text: '', isCorrect: false },
          { text: '', isCorrect: false },
          { text: '', isCorrect: false },
        ]);
      } else {
        setStatusMsg('Error: ' + data.error);
      }
    } catch (err) {
      setStatusMsg('Failed to connect to server.');
    }
  };

  return (
    <div className="max-w-3xl mx-auto p-8 text-black">
      <div className="flex justify-between items-center mb-6 border-b pb-4">
        <h1 className="text-3xl font-bold text-blue-800">Admin Dashboard</h1>
        <Link href="/" className="text-gray-600 hover:text-blue-600 font-medium">← Back to Home</Link>
      </div>

      <form onSubmit={handleSubmit} className="bg-white p-6 rounded-lg shadow-md border">
        <h2 className="text-xl font-bold mb-4">Add New Question</h2>
        
        <div className="grid grid-cols-2 gap-4 mb-4">
          <div>
            <label className="block font-bold mb-1">Exam Code</label>
            <select value={examCode} onChange={(e) => setExamCode(e.target.value)} className="w-full p-2 border rounded">
              {['A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'].map(code => (
                <option key={code} value={code}>{code}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block font-bold mb-1">Topic / Subcategory</label>
            <input type="text" required value={topic} onChange={(e) => setTopic(e.target.value)} placeholder="e.g., Engine Diagnosis" className="w-full p-2 border rounded" />
          </div>
        </div>

        <div className="mb-4">
          <label className="block font-bold mb-1">Question Text</label>
          <textarea required value={stemText} onChange={(e) => setStemText(e.target.value)} rows={3} className="w-full p-2 border rounded" placeholder="Technician A says..."></textarea>
        </div>

        <div className="mb-6">
          <label className="block font-bold mb-1">Explanation</label>
          <textarea required value={explanationText} onChange={(e) => setExplanationText(e.target.value)} rows={2} className="w-full p-2 border rounded" placeholder="This is correct because..."></textarea>
        </div>

        <h3 className="font-bold mb-2">Multiple Choices</h3>
        <p className="text-sm text-gray-500 mb-3">Select the radio button next to the correct answer.</p>
        
        <div className="space-y-3 mb-6">
          {choices.map((choice, index) => (
            <div key={index} className="flex items-center gap-3">
              <input 
                type="radio" 
                name="correctAnswer" 
                checked={choice.isCorrect} 
                onChange={() => handleCorrectChange(index)}
                className="w-5 h-5 cursor-pointer"
              />
              <input 
                type="text" 
                required 
                value={choice.text} 
                onChange={(e) => handleChoiceChange(index, e.target.value)} 
                placeholder={`Option ${index + 1}`} 
                className={`w-full p-2 border rounded ${choice.isCorrect ? 'bg-green-50 border-green-400' : ''}`}
              />
            </div>
          ))}
        </div>

        <button type="submit" className="w-full bg-blue-600 text-white font-bold py-3 rounded hover:bg-blue-700 transition-colors">
          Publish Question to Database
        </button>

        {statusMsg && (
          <div className={`mt-4 p-3 text-center font-bold rounded ${statusMsg.includes('Error') || statusMsg.includes('Failed') ? 'bg-red-100 text-red-700' : 'bg-green-100 text-green-700'}`}>
            {statusMsg}
          </div>
        )}
      </form>
    </div>
  );
}