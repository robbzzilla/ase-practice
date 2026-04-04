'use client';
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer } from 'recharts';

// 1. Define the blueprint for the incoming stats
interface TopicStat {
  correct: number;
  total: number;
}

// 2. Define the blueprint for the component props
interface PerformanceChartProps {
  topicData: Record<string, TopicStat>;
}

export default function PerformanceChart({ topicData }: PerformanceChartProps) {
  // Format the data for Recharts
  const data = Object.entries(topicData).map(([topic, stats]) => ({
    subject: topic,
    A: Math.round((stats.correct / stats.total) * 100),
    fullMark: 100,
  }));

  if (data.length === 0) return <p className="text-gray-500 italic text-sm">No data to display yet.</p>;

  return (
    <div className="w-full h-64 bg-white rounded-lg shadow-sm border p-4">
      <ResponsiveContainer width="100%" height="100%">
        <RadarChart cx="50%" cy="50%" outerRadius="80%" data={data}>
          <PolarGrid />
          <PolarAngleAxis dataKey="subject" tick={{ fill: '#4b5563', fontSize: 12 }} />
          <PolarRadiusAxis angle={30} domain={[0, 100]} />
          <Radar name="Score" dataKey="A" stroke="#2563eb" fill="#3b82f6" fillOpacity={0.6} />
        </RadarChart>
      </ResponsiveContainer>
    </div>
  );
}