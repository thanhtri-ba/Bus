import { Navigate, Outlet } from 'react-router-dom'; import { useAuthStore,type UserRole } from '@/store/auth.store';
export function RoleRoute({allowed}:{allowed:UserRole[]}){const user=useAuthStore(s=>s.user);return user?.roles.some(role=>allowed.includes(role))?<Outlet/>:<Navigate to="/forbidden" replace/>}
