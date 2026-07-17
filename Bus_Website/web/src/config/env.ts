const fallback='http://localhost:3000/api';
export const env={apiBaseUrl:import.meta.env.VITE_API_BASE_URL?.trim()||fallback,isDevelopment:import.meta.env.DEV} as const;
