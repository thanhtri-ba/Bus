import { Link } from 'react-router-dom';

export function Footer() {
  return (
    <footer className="bg-surface-container-low border-t border-outline-variant full-width mt-12">
      <div className="w-full px-gutter py-12 max-w-container-max mx-auto grid grid-cols-1 md:grid-cols-4 gap-8">
        <div className="flex flex-col gap-4">
          <img alt="Intercity Velocity Logo" className="h-12 w-auto object-contain self-start" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCelJ0Ziq9B5uQHmRdkLwuC1cKO3i9SILb06IZ_UShsi048LflRR07g2MaiQGzVDD8NUDdw0n-Ej4iueLq7OqE0DOltMlgNA8KBzspoVmrNewWobJQyeoPUd8fN-HwLEumtKLtgq-SwQmWAYM1mk0fB1DIkdD3PPDAnxaejRhBoD8bhYMAxbFC0KLKDgMeezqYMd6RIVrZ8i6PhF9nT4jca_zbyvQKsHy5KBW2FoOU38Jx9aOWqkN7d5w" />
          <p className="font-body-sm text-on-surface-variant pr-4">© 2024 Intercity Velocity. Reliable intercity travel. Connecting people with precision and care.</p>
        </div>
        <div className="flex flex-col gap-3">
          <h4 className="font-label-md text-label-md text-on-surface uppercase tracking-wider">Company</h4>
          <ul className="space-y-2">
            <li><Link to="/about" className="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary hover:underline transition-colors">About Us</Link></li>
            <li><Link to="/partners" className="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary hover:underline transition-colors">Bus Partners</Link></li>
            <li><a className="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary hover:underline transition-colors" href="#">Careers</a></li>
          </ul>
        </div>
        <div className="flex flex-col gap-3">
          <h4 className="font-label-md text-on-surface font-bold uppercase tracking-wider mb-2">Support</h4>
          <a className="font-body-sm text-on-surface-variant hover:text-secondary active:underline transition-colors" href="#">Contact Support</a>
          <a className="font-body-sm text-on-surface-variant hover:text-secondary active:underline transition-colors" href="#">Terms of Service</a>
          <a className="font-body-sm text-on-surface-variant hover:text-secondary active:underline transition-colors" href="#">Privacy Policy</a>
        </div>
        <div className="flex flex-col gap-4">
          <h4 className="font-label-md text-on-surface font-bold uppercase tracking-wider mb-2">Subscribe</h4>
          <p className="font-body-sm text-on-surface-variant">Get exclusive travel deals in your inbox.</p>
          <div className="flex gap-2">
            <input className="bg-surface border-outline-variant rounded-lg p-2 text-body-sm w-full" placeholder="Email" type="email" />
            <button className="bg-primary text-on-primary px-4 py-2 rounded-lg font-bold">Join</button>
          </div>
        </div>
      </div>
    </footer>
  );
}
