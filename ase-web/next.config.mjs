/** @type {import('next').NextConfig} */
const nextConfig = {
  allowedDevOrigins: [
    '3000-cs-3bbf25b9-5421-4015-beb7-7b4357c2fdca.cs-us-central1-pits.cloudshell.dev',
    '127.0.0.1' // <-- Add this line right here!
  ],
  async rewrites() {
    return [
      {
        source: '/api/exams/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/exams/:path*', 
      },
      {
        source: '/api/scores/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/scores/:path*', 
      },
      {
        source: '/api/admin/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/admin/:path*', 
      },
      {
        source: '/api/gamify/:path*',
        destination: 'https://ase-api-111944353412.us-central1.run.app/api/gamify/:path*', 
      }
    ]
  }
};

export default nextConfig;