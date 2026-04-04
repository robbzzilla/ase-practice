/** @type {import('next').NextConfig} */
const nextConfig = {
  allowedDevOrigins: ['3000-cs-3bbf25b9-5421-4015-beb7-7b4357c2fdca.cs-us-central1-pits.cloudshell.dev'],
  async rewrites() {
    return [
      // 1. Proxy exam requests to the backend
      {
        source: '/api/exams/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/exams/:path*', 
      },
      // 2. Proxy score requests to the backend
      {
        source: '/api/scores/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/scores/:path*', 
      }
      // Notice we DO NOT proxy /api/auth/ so NextAuth can handle it locally!
    ]
  }
};
export default nextConfig;