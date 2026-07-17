import { Link, useLocation } from 'react-router-dom';
import { useState, useEffect } from 'react';

export function Header() {
  const location = useLocation();
  const isActive = (path: string) => location.pathname === path;
  const [user, setUser] = useState<any>(null);

  const checkAuth = () => {
    const userStr = localStorage.getItem('user');
    if (userStr) {
      try {
        setUser(JSON.parse(userStr));
      } catch (e) {
        setUser(null);
      }
    } else {
      setUser(null);
    }
  };

  useEffect(() => {
    checkAuth();
    window.addEventListener('auth-change', checkAuth);
    return () => window.removeEventListener('auth-change', checkAuth);
  }, []);

  return (
    <header className="bg-surface docked full-width top-0 z-50 shadow-sm">
      <div className="flex justify-between items-center w-full px-gutter max-w-container-max mx-auto h-16">
        <div className="flex items-center gap-2">
          <Link to="/">
            <img alt="Intercity Velocity Logo" className="h-10 w-auto object-contain" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCelJ0Ziq9B5uQHmRdkLwuC1cKO3i9SILb06IZ_UShsi048LflRR07g2MaiQGzVDD8NUDdw0n-Ej4iueLq7OqE0DOltMlgNA8KBzspoVmrNewWobJQyeoPUd8fN-HwLEumtKLtgq-SwQmWAYM1mk0fB1DIkdD3PPDAnxaejRhBoD8bhYMAxbFC0KLKDgMeezqYMd6RIVrZ8i6PhF9nT4jca_zbyvQKsHy5KBW2FoOU38Jx9aOWqkN7d5w" />
          </Link>
        </div>
        <nav className="hidden md:flex items-center gap-8">
          <Link to="/search" className={`pb-1 font-label-md transition-colors ${isActive('/search') ? 'text-primary font-bold border-b-2 border-primary' : 'text-on-surface-variant hover:text-primary'}`}>Search</Link>
          <Link to="/my-bookings" className={`pb-1 font-label-md transition-colors ${isActive('/my-bookings') ? 'text-primary font-bold border-b-2 border-primary' : 'text-on-surface-variant hover:text-primary'}`}>My Bookings</Link>
          <Link to="/offers" className={`pb-1 font-label-md transition-colors ${isActive('/offers') ? 'text-primary font-bold border-b-2 border-primary' : 'text-on-surface-variant hover:text-primary'}`}>Offers</Link>
          <Link to="/about" className={`font-label-md text-label-md pb-1 transition-colors ${isActive('/about') ? 'text-primary border-b-2 border-primary font-bold' : 'text-on-surface-variant hover:text-primary'}`}>
            About Us
          </Link>
          <Link to="/help" className={`font-label-md text-label-md pb-1 transition-colors ${isActive('/help') ? 'text-primary border-b-2 border-primary font-bold' : 'text-on-surface-variant hover:text-primary'}`}>
            Help
          </Link>
        </nav>
        <div className="flex items-center gap-4">
          {user ? (
            <Link to="/profile" className="flex items-center gap-4 hover:opacity-80 transition-opacity">
              <div className="hidden md:flex items-center gap-2 bg-surface-container-high px-3 py-1.5 rounded-full border border-outline-variant">
                <span className="material-symbols-outlined text-[18px] text-secondary">stars</span>
                <span className="font-label-md text-on-surface">1,240 <span className="text-on-surface-variant font-normal">pts</span></span>
              </div>
              <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center text-white font-bold text-sm">
                {user.email ? user.email.substring(0, 2).toUpperCase() : 'U'}
              </div>
            </Link>
          ) : (
            <Link to="/auth" className="bg-primary text-on-primary px-5 py-2 rounded-lg font-label-md hover:bg-primary/90 transition-all">
              Log In
            </Link>
          )}
        </div>
      </div>
    </header>
  );
}
