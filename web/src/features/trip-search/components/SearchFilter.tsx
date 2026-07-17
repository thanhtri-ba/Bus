export function SearchFilter() {
  return (
    <aside className="hidden lg:block space-y-6">
      <div className="bg-surface-container-lowest p-6 rounded-xl border border-outline-variant shadow-level-2">
        <div className="flex items-center justify-between mb-6">
          <h2 className="font-headline-md text-headline-md text-on-surface">Filters</h2>
          <button className="text-primary font-label-md text-label-md hover:underline">Reset All</button>
        </div>
        {/* Departure Time */}
        <div className="mb-8">
          <h3 className="font-label-md text-label-md mb-4 text-on-surface">Departure Time</h3>
          <div className="space-y-3">
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">wb_sunny</span>
                <span className="font-body-md text-body-md">Morning (06:00 - 12:00)</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">wb_twilight</span>
                <span className="font-body-md text-body-md">Afternoon (12:00 - 18:00)</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">dark_mode</span>
                <span className="font-body-md text-body-md">Night (18:00 - 06:00)</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
          </div>
        </div>
        {/* Price Range */}
        <div className="mb-8">
          <h3 className="font-label-md text-label-md mb-4 text-on-surface">Price Range</h3>
          <div className="px-2">
            <input className="w-full h-2 bg-outline-variant rounded-lg appearance-none cursor-pointer accent-primary" max="1000" min="100" type="range" />
            <div className="flex justify-between mt-4">
              <span className="bg-surface-container p-2 rounded text-label-sm font-label-sm">$100</span>
              <span className="bg-surface-container p-2 rounded text-label-sm font-label-sm">$1000</span>
            </div>
          </div>
        </div>
        {/* Bus Type */}
        <div>
          <h3 className="font-label-md text-label-md mb-4 text-on-surface">Bus Type</h3>
          <div className="space-y-3">
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">airline_seat_flat</span>
                <span className="font-body-md text-body-md">Sleeper</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">diamond</span>
                <span className="font-body-md text-body-md">Limousine</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
            <label className="flex items-center justify-between cursor-pointer group">
              <div className="flex items-center gap-3">
                <span className="material-symbols-outlined text-outline group-hover:text-primary">directions_bus</span>
                <span className="font-body-md text-body-md">Luxury Seating</span>
              </div>
              <input className="rounded text-primary focus:ring-primary h-5 w-5" type="checkbox" />
            </label>
          </div>
        </div>
      </div>
    </aside>
  );
}
