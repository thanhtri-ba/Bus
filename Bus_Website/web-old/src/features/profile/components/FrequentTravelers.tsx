export function FrequentTravelers() {
  const travelers = [
    { initials: 'MS', name: 'Mark Smith', detail: 'Brother • Adult' },
    { initials: 'LS', name: 'Lily Smith', detail: 'Daughter • Child' }
  ];

  return (
    <section className="bg-surface-container-lowest rounded-xl border border-outline-variant shadow-[0px_4px_12px_rgba(0,0,0,0.05)] overflow-hidden">
      <div className="px-6 py-5 border-b border-outline-variant flex justify-between items-center">
        <div className="flex items-center space-x-3">
          <h3 className="font-headline-md text-headline-md text-on-surface">Frequent Travelers</h3>
          <span className="bg-surface-container-highest text-on-surface-variant px-2 py-0.5 rounded text-[12px] font-bold">
            {travelers.length} Saved
          </span>
        </div>
        <button className="inline-flex items-center space-x-1.5 bg-primary text-white font-label-md text-label-md px-4 py-2 rounded-lg hover:opacity-90 transition-all">
          <span className="material-symbols-outlined text-[18px]">add</span>
          <span>Add New</span>
        </button>
      </div>
      <div className="p-6 grid grid-cols-1 md:grid-cols-2 gap-4">
        {travelers.map((traveler, index) => (
          <div key={index} className="border border-outline-variant rounded-xl p-4 flex items-center space-x-4 hover:border-primary transition-colors cursor-pointer group">
            <div className="w-12 h-12 rounded-full bg-surface-container-high flex items-center justify-center text-primary font-bold">
              {traveler.initials}
            </div>
            <div className="flex-grow">
              <h4 className="font-label-md text-label-md text-on-surface">{traveler.name}</h4>
              <p className="font-body-sm text-body-sm text-on-surface-variant">{traveler.detail}</p>
            </div>
            <button className="p-2 text-on-surface-variant hover:text-error opacity-0 group-hover:opacity-100 transition-opacity">
              <span className="material-symbols-outlined text-[20px]">delete</span>
            </button>
          </div>
        ))}
      </div>
    </section>
  );
}
