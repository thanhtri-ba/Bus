export type TabValue = 'upcoming' | 'history' | 'cancelled';

interface BookingsTabsProps {
  activeTab: TabValue;
  onTabChange: (tab: TabValue) => void;
  upcomingCount: number;
}

export function BookingsTabs({ activeTab, onTabChange, upcomingCount }: BookingsTabsProps) {
  const tabs = [
    { value: 'upcoming', label: `Upcoming Trips (${upcomingCount})` },
    { value: 'history', label: 'Travel History' },
    { value: 'cancelled', label: 'Cancelled' }
  ] as const;

  return (
    <div className="flex border-b border-outline-variant mb-8 overflow-x-auto custom-scrollbar">
      {tabs.map(tab => (
        <button
          key={tab.value}
          onClick={() => onTabChange(tab.value)}
          className={`px-6 py-3 font-label-md whitespace-nowrap transition-colors ${
            activeTab === tab.value
              ? 'text-primary border-b-2 border-primary'
              : 'text-on-surface-variant hover:text-primary'
          }`}
        >
          {tab.label}
        </button>
      ))}
    </div>
  );
}
