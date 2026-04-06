import withPWAInit from "@ducanh2912/next-pwa";

const withPWA = withPWAInit({
  dest: "public",
  cacheOnFrontEndNav: true,
  aggressiveFrontEndNavCaching: true,
  reloadOnOnline: true,
  disable: process.env.NODE_ENV === "development", 
  workboxOptions: {
    disableDevLogs: true,
  },
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  turbopack: {}, // <-- THIS FIXES THE BUILD CRASH
  async rewrites() {
    const API_URL = "https://ase-api-111944353412.us-central1.run.app";
    
    return [
      { source: '/api/exams/:path*', destination: `${API_URL}/api/exams/:path*` },
      { source: '/api/scores/:path*', destination: `${API_URL}/api/scores/:path*` },
      { source: '/api/admin/:path*', destination: `${API_URL}/api/admin/:path*` },
      { source: '/api/gamify/:path*', destination: `${API_URL}/api/gamify/:path*` }
    ];
  }
};

export default withPWA(nextConfig);
