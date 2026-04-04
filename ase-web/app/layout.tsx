import AuthProvider from './components/AuthProvider';
import './globals.css';

export const metadata = {
  title: 'ASE Practice Platform',
  description: 'Master your ASE Certification Exams',
  manifest: '/manifest.json',
};

export const viewport = {
  themeColor: '#2563eb',
};

// Notice the added type definition for children right here:
export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <AuthProvider>
          {children}
        </AuthProvider>
      </body>
    </html>
  );
}