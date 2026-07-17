import { useState } from 'react';

export function PartnersSearchFilter() {
  const [activeFilter, setActiveFilter] = useState('All Types');

  const filters = ['All Types', 'Luxury', 'Sleeper', 'Limousine'];

  return (
    <div className="bg-surface-container-lowest partner-card-shadow rounded-xl p-4 mb-12 border border-surface-variant">
      <div className="grid grid-cols-1 md:grid-cols-12 gap-4 items-center">
        {/* Search Input */}
        <div className="md:col-span-5 relative">
          <span className="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-outline">search</span>
          <input 
            className="w-full pl-12 pr-4 py-3 rounded-lg border border-outline-variant focus:border-primary focus:ring-1 focus:ring-primary outline-none font-body-md bg-surface" 
            placeholder="Search bus operators..." 
            type="text" 
          />
        </div>
        
        {/* Filter Group */}
        <div className="md:col-span-5 flex flex-wrap gap-2">
          {filters.map(filter => (
            <button
              key={filter}
              onClick={() => setActiveFilter(filter)}
              className={`px-4 py-2 rounded-full border font-label-md transition-colors ${
                activeFilter === filter
                  ? 'border-primary text-primary bg-primary/5 hover:bg-primary/10'
                  : 'border-outline-variant text-on-surface-variant hover:bg-surface-container-high'
              }`}
            >
              {filter}
            </button>
          ))}
        </div>
        
        {/* Sort Dropdown */}
        <div className="md:col-span-2 text-right">
          <select className="w-full py-3 px-4 rounded-lg border border-outline-variant font-label-md text-on-surface-variant bg-surface outline-none focus:border-primary">
            <option>Top Rated</option>
            <option>Popularity</option>
            <option>Partner Since</option>
          </select>
        </div>
      </div>
    </div>
  );
}
