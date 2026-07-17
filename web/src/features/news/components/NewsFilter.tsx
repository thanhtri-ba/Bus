import { useState } from 'react';

export function NewsFilter() {
  const [activeTab, setActiveTab] = useState('all');

  const tabs = [
    { id: 'all', label: 'Tất cả' },
    { id: 'promotions', label: 'Khuyến mãi' },
    { id: 'news', label: 'Tin tức' },
    { id: 'tips', label: 'Kinh nghiệm du lịch' },
  ];

  return (
    <section className="sticky top-16 z-40 bg-surface/90 backdrop-blur-md py-4 -mx-gutter px-gutter">
      <div className="flex items-center gap-2 overflow-x-auto no-scrollbar pb-2 md:pb-0">
        {tabs.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`px-6 py-2 rounded-full font-label-md whitespace-nowrap transition-colors ${
              activeTab === tab.id
                ? 'bg-primary text-on-primary'
                : 'border border-outline-variant text-on-surface-variant hover:border-primary hover:text-primary'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>
    </section>
  );
}
