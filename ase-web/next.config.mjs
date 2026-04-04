import { withSentryConfig } from '@sentry/nextjs';
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

export default withSentryConfig(withPWA(nextConfig), {
  // For all available options, see:
  // https://www.npmjs.com/package/@sentry/webpack-plugin#options

  org: "cincinnati-region",

  project: "ase-practice",

  // Only print logs for uploading source maps in CI
  silent: !process.env.CI,

  // For all available options, see:
  // https://docs.sentry.io/platforms/javascript/guides/nextjs/manual-setup/

  // Upload a larger set of source maps for prettier stack traces (increases build time)
  widenClientFileUpload: true,

  // Uncomment to route browser requests to Sentry through a Next.js rewrite to circumvent ad-blockers.
  // This can increase your server load as well as your hosting bill.
  // Note: Check that the configured route will not match with your Next.js middleware, otherwise reporting of client-
  // side errors will fail.
  // tunnelRoute: "/monitoring",

  webpack: {
    // Enables automatic instrumentation of Vercel Cron Monitors. (Does not yet work with App Router route handlers.)
    // See the following for more information:
    // https://docs.sentry.io/product/crons/
    // https://vercel.com/docs/cron-jobs
    automaticVercelMonitors: true,

    // Tree-shaking options for reducing bundle size
    treeshake: {
      // Automatically tree-shake Sentry logger statements to reduce bundle size
      removeDebugLogging: true,
    },
  }
});
