export interface NotificationProps {
  id: string;
  category: 'bookings' | 'promotions' | 'system';
  title: string;
  time: string;
  content: string;
  badgeLabel: string;
  icon: string;
  isUnread?: boolean;
}

export function NotificationCard({ category, title, time, content, badgeLabel, icon, isUnread }: NotificationProps) {
  let bgClass = '';
  let textClass = '';
  
  let badgeTextClass = '';
  
  if (category === 'bookings') {
    bgClass = 'bg-primary-fixed';
    textClass = 'text-primary';
    badgeTextClass = 'text-on-primary-fixed';
  } else if (category === 'promotions') {
    bgClass = 'bg-secondary-fixed';
    textClass = 'text-secondary';
    badgeTextClass = 'text-on-secondary-fixed';
  } else if (category === 'system') {
    bgClass = 'bg-tertiary-fixed';
    textClass = 'text-tertiary';
    badgeTextClass = 'text-on-tertiary-fixed';
  }

  return (
    <div className={`notification-card p-5 rounded-xl border border-outline-variant shadow-sm flex gap-4 group cursor-pointer ${isUnread ? 'bg-surface-container-lowest' : 'bg-surface-container-lowest opacity-70'}`}>
      <div className={`w-12 h-12 rounded-full ${bgClass} flex items-center justify-center shrink-0 ${!isUnread && 'opacity-60'}`}>
        <span className={`material-symbols-outlined ${textClass}`} style={category === 'system' ? { fontVariationSettings: "'FILL' 1" } : {}}>
          {icon}
        </span>
      </div>
      <div className="flex-1">
        <div className="flex justify-between items-start mb-1">
          <h3 className="font-headline-md text-headline-md text-on-surface">{title}</h3>
          <span className="font-label-sm text-label-sm text-on-surface-variant">{time}</span>
        </div>
        <p className="font-body-md text-body-md text-on-surface-variant mb-2">{content}</p>
        <div className="flex gap-2 items-center">
          <span className={`px-3 py-1 ${bgClass} ${badgeTextClass} text-[12px] font-medium rounded-full`}>
            {badgeLabel}
          </span>
          {isUnread && <span className="w-2 h-2 bg-primary rounded-full ml-1"></span>}
        </div>
      </div>
    </div>
  );
}
