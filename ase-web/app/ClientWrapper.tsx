'use client';
import { useState, useEffect } from "react";
import Link from "next/link";
import { SessionProvider } from "next-auth/react";
import { Toaster } from "react-hot-toast";

export default function ClientWrapper({ children }: { children: React.ReactNode }) {
  const [isDarkMode, setIsDarkMode] = useState(false);

  useEffect(() => {
    if (isDarkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [isDarkMode]);

  return (
    <SessionProvider>
      <Toaster position="bottom-center" toastOptions={{ className: 'dark:bg-gray-800 dark:text-white border dark:border-gray-700', duration: 4000 }} />
      <header className="bg-white dark:bg-gray-800 shadow-sm border-b dark:border-gray-700 p-4">
        <div className="max-w-6xl mx-auto flex flex-col md:flex-row justify-between items-center gap-4">
          <Link href="/" className="text-2xl font-bold text-blue-600 dark:text-blue-400">ASE Practice</Link>
          <div className="flex items-center gap-6">
            <label className="flex items-center cursor-pointer">
              <div className="relative">
                <input type="checkbox" className="sr-only" checked={isDarkMode} onChange={() => setIsDarkMode(!isDarkMode)} />
                <div className="block bg-gray-300 dark:bg-gray-600 w-10 h-6 rounded-full"></div>
                <div className={`dot absolute left-1 top-1 bg-white w-4 h-4 rounded-full transition transform ${isDarkMode ? 'translate-x-4' : ''}`}></div>
              </div>
              <span className="ml-2 text-sm font-medium">Dark</span>
            </label>
          </div>
        </div>
      </header>
      <main className="p-4 md:p-8">{children}</main>
    </SessionProvider>
  );
}
