'use client';
import { useState } from 'react';

export default function Leaderboard() {
  // Added 'Overall' to the beginning of the array
  const [selectedExam, setSelectedExam] = useState('Overall');
  const tabs = ['Overall', 'A1', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8'];

  // Dummy data for demonstration. In production, fetch this from your API.
  const allScores = [
    { id: 1, name: 'Christopher LongNameington', score: 98, exam: 'A1' },
    { id: 2, name: 'Jane Doe', score: 95, exam: 'A1' },
    { id: 3, name: 'John Smith', score: 92, exam: 'A2' },
    { id: 4, name: 'Sarah Jenkins', score: 99, exam: 'A8' },
    { id: 5, name: 'Mike Ross', score: 88, exam: 'A1' },
  ];

  // Filter logic: If 'Overall', show top scores across all exams. Otherwise, filter by exam code.
  const filteredData = selectedExam === 'Overall' 
    ? [...allScores].sort((a, b) => b.score - a.score).slice(0, 10) // Top 10 overall
    : allScores.filter(score => score.exam === selectedExam).sort((a, b) => b.score - a.score);

  return (
    <div className="bg-white dark:bg-gray-800 rounded-xl shadow p-4 md:p-6 mt-8 border dark:border-gray-700 transition-colors">
      <h2 className="text-2xl font-bold mb-4 text-gray-900 dark:text-white">Top Performers</h2>
      
      {/* Category Tabs */}
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

      {/* Responsive Table Wrapper */}
      <div className="overflow-x-auto">
        <table className="w-full text-left border-collapse">
          <thead>
            <tr className="border-b dark:border-gray-700 text-gray-600 dark:text-gray-400">
              <th className="p-3 font-semibold">Rank</th>
              <th className="p-3 font-semibold">Technician</th>
              {selectedExam === 'Overall' && <th className="p-3 font-semibold">Exam</th>}
              <th className="p-3 font-semibold">Score</th>
            </tr>
          </thead>
          <tbody>
            {filteredData.length > 0 ? (
              filteredData.map((row, index) => (
                <tr key={row.id} className="border-b dark:border-gray-700/50 hover:bg-gray-50 dark:hover:bg-gray-700/25 transition-colors">
                  <td className="p-3 text-gray-900 dark:text-gray-100">{index + 1}</td>
                  <td className="p-3 max-w-[120px] md:max-w-xs truncate font-medium text-gray-900 dark:text-gray-100" title={row.name}>
                    {row.name}
                  </td>
                  {selectedExam === 'Overall' && (
                    <td className="p-3 text-gray-600 dark:text-gray-400 text-sm">{row.exam}</td>
                  )}
                  <td className="p-3 text-green-600 dark:text-green-400 font-bold">{row.score}%</td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan={selectedExam === 'Overall' ? 4 : 3} className="p-6 text-center text-gray-500 dark:text-gray-400 italic">
                  No scores recorded for {selectedExam} yet.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}