import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { useAuthStore } from '@/store/auth.store';
export function ProtectedRoute(){const status=useAuthStore(s=>s.status);const location=useLocation();if(status==='idle'||status==='loading')return <div className="page-center">Đang kiểm tra phiên đăng nhập…</div>;return status==='authenticated'?<Outlet/>:<Navigate to="/login" replace state={{from:location.pathname}}/>}
