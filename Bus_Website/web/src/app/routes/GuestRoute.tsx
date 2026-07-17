import { Navigate, Outlet } from 'react-router-dom'; import { useAuthStore } from '@/store/auth.store';
export function GuestRoute(){return useAuthStore(s=>s.status)==='authenticated'?<Navigate to="/account" replace/>:<Outlet/>}
