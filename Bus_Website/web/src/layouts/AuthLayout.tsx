import { NavLink, Outlet } from 'react-router-dom';
export function AuthLayout(){return <main className="auth-layout"><NavLink to="/" className="brand">Bus<span>Z</span></NavLink><div className="auth-panel"><Outlet/></div></main>}
