export function Pagination() {
  return (
    <div className="mt-16 flex justify-center items-center gap-4">
      <button className="p-2 rounded-lg border border-outline-variant hover:bg-surface-container transition-colors disabled:opacity-50" disabled>
        <span className="material-symbols-outlined">chevron_left</span>
      </button>
      <div className="flex gap-2">
        <button className="w-10 h-10 rounded-lg bg-primary text-on-primary font-label-md">1</button>
        <button className="w-10 h-10 rounded-lg border border-outline-variant hover:bg-surface-container font-label-md transition-colors">2</button>
        <button className="w-10 h-10 rounded-lg border border-outline-variant hover:bg-surface-container font-label-md transition-colors">3</button>
        <span className="w-10 h-10 flex items-center justify-center">...</span>
        <button className="w-10 h-10 rounded-lg border border-outline-variant hover:bg-surface-container font-label-md transition-colors">12</button>
      </div>
      <button className="p-2 rounded-lg border border-outline-variant hover:bg-surface-container transition-colors">
        <span className="material-symbols-outlined">chevron_right</span>
      </button>
    </div>
  );
}
