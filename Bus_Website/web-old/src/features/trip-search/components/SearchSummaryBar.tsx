export function SearchSummaryBar() {
  return (
    <section className="bg-surface-container-low border-b border-outline-variant py-4">
      <div className="max-w-container-max mx-auto px-gutter flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <div className="bg-surface p-3 rounded-xl border border-outline-variant flex items-center gap-3">
            <span className="material-symbols-outlined text-primary">location_on</span>
            <div className="flex flex-col">
              <span className="font-label-sm text-label-sm text-outline">From</span>
              <span className="font-label-md text-label-md">Hanoi</span>
            </div>
          </div>
          <span className="material-symbols-outlined text-outline">swap_horiz</span>
          <div className="bg-surface p-3 rounded-xl border border-outline-variant flex items-center gap-3">
            <span className="material-symbols-outlined text-primary">location_on</span>
            <div className="flex flex-col">
              <span className="font-label-sm text-label-sm text-outline">To</span>
              <span className="font-label-md text-label-md">Sapa</span>
            </div>
          </div>
          <div className="bg-surface p-3 rounded-xl border border-outline-variant flex items-center gap-3">
            <span className="material-symbols-outlined text-primary">calendar_month</span>
            <div className="flex flex-col">
              <span className="font-label-sm text-label-sm text-outline">Date</span>
              <span className="font-label-md text-label-md">Fri, Oct 25</span>
            </div>
          </div>
        </div>
        <button className="bg-secondary-container text-on-primary px-8 py-3 rounded-xl font-bold hover:opacity-90 transition-all flex items-center gap-2">
          <span className="material-symbols-outlined">edit</span>
          Modify Search
        </button>
      </div>
    </section>
  );
}
