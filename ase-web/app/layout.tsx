import type { Metadata } from 'next';
import ClientWrapper from './ClientWrapper';
import "./globals.css";

export const metadata: Metadata = {
  metadataBase: new URL('https://ase-web-111944353412.us-central1.run.app'),
  title: 'ASE Practice Platform',
  description: 'Master your ASE certification exams with our interactive practice tests, detailed explanations, and global leaderboard.',
  openGraph: {
    title: 'ASE Practice Platform',
    description: 'Master your ASE certification exams with our interactive practice tests, detailed explanations, and global leaderboard.',
    url: '/',
    siteName: 'ASE Practice',
    images: [
      {
        url: '/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'ASE Practice Platform Preview',
      },
    ],
    locale: 'en_US',
    type: 'website',
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body className="bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-gray-100 min-h-screen transition-colors duration-200">
        <ClientWrapper>
          {children}
        </ClientWrapper>
      </body>
    </html>
  );
}
