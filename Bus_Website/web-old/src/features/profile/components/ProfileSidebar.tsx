import { useState } from 'react';

export function ProfileSidebar() {
  const [activeTab, setActiveTab] = useState('Personal Info');

  const navItems = [
    { icon: 'person', label: 'Personal Info' },
    { icon: 'payments', label: 'Payment Methods' },
    { icon: 'notifications', label: 'Notifications' },
    { icon: 'lock', label: 'Password & Security' }
  ];

  return (
    <aside className="w-full md:w-64 flex-shrink-0">
      <div className="bg-surface-container-lowest rounded-xl border border-outline-variant overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
        <div className="p-4 border-b border-outline-variant">
          <h2 className="font-headline-md text-headline-md text-on-surface">Settings</h2>
        </div>
        <nav className="p-2 space-y-1">
          {navItems.map(item => (
            <button
              key={item.label}
              onClick={() => setActiveTab(item.label)}
              className={`w-full flex items-center space-x-3 px-4 py-3 rounded-lg transition-all text-left ${
                activeTab === item.label
                  ? 'bg-surface-container text-primary font-bold'
                  : 'text-on-surface-variant hover:bg-surface-container-low'
              }`}
            >
              <span className="material-symbols-outlined">{item.icon}</span>
              <span className="font-label-md text-label-md">{item.label}</span>
            </button>
          ))}
          <div className="pt-4 mt-4 border-t border-outline-variant">
            <button className="w-full flex items-center space-x-3 px-4 py-3 rounded-lg text-error hover:bg-error-container/10 transition-all text-left">
              <span className="material-symbols-outlined">logout</span>
              <span className="font-label-md text-label-md">Sign Out</span>
            </button>
          </div>
        </nav>
      </div>
      
      {/* Loyalty Status Card */}
      <div className="mt-6 bg-gradient-to-br from-primary to-primary-container p-6 rounded-xl text-white relative overflow-hidden shadow-[0px_4px_12px_rgba(0,0,0,0.05)]">
        <div className="relative z-10">
          <span className="font-label-sm text-label-sm uppercase tracking-wider opacity-80">Velocity Rewards</span>
          <div className="mt-2 flex items-baseline space-x-1">
            <span className="font-headline-lg text-headline-lg">1,240</span>
            <span className="font-body-sm text-body-sm">Points</span>
          </div>
          <div className="mt-4 bg-white/20 h-1.5 rounded-full w-full">
            <div className="bg-secondary-container h-full rounded-full w-3/4"></div>
          </div>
          <p className="mt-2 font-label-sm text-label-sm opacity-90">260 points until Silver Status</p>
        </div>
        <span className="material-symbols-outlined absolute -bottom-4 -right-4 text-[96px] opacity-10 rotate-12">auto_awesome</span>
      </div>
    </aside>
  );
}
