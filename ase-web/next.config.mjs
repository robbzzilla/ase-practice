import withPWAInit from "@ducanh2912/next-pwa";

// NEW: Automatically switch between local and live API!
const isDev = process.env.NODE_ENV === "development";
const API_URL = isDev ? "http://127.0.0.1:8080" : "https://ase-api-111944353412.us-central1.run.app";

const withPWA = withPWAInit({
  dest: "public",
  cacheOnFrontEndNav: true,
  aggressiveFrontEndNavCaching: true,
  reloadOnOnline: true,
  disable: isDev, 
  workboxOptions: {
    disableDevLogs: true,
  },
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  turbopack: {}, 
  allowedDevOrigins: [
    '3000-cs-3bbf25b9-5421-4015-beb7-7b4357c2fdca.cs-us-central1-pits.cloudshell.dev',
    '127.0.0.1'
  ],
  async rewrites() {
    return [
      { source: '/api/exams/:path*', destination: `${API_URL}/api/exams/:path*` },
      { source: '/api/scores/:path*', destination: `${API_URL}/api/scores/:path*` },
      { source: '/api/admin/:path*', destination: `${API_URL}/api/admin/:path*` },
      { source: '/api/gamify/:path*', destination: `${API_URL}/api/gamify/:path*` }
    ]
  }
};

export default withPWA(nextConfig);