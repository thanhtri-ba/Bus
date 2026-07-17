export function MobileBottomNav() {
  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-surface shadow-lg flex items-center justify-around h-16 px-4 z-[100] border-t border-outline-variant">
      <button className="flex flex-col items-center gap-1 text-primary">
        <span className="material-symbols-outlined">search</span>
        <span className="text-[10px] font-bold">Search</span>
      </button>
      <button className="flex flex-col items-center gap-1 text-outline">
        <span className="material-symbols-outlined">confirmation_number</span>
        <span className="text-[10px]">Bookings</span>
      </button>
      <button className="flex flex-col items-center gap-1 text-outline">
        <span className="material-symbols-outlined">help</span>
        <span className="text-[10px]">Support</span>
      </button>
      <button className="flex flex-col items-center gap-1 text-outline">
        <span className="material-symbols-outlined">person</span>
        <span className="text-[10px]">Account</span>
      </button>
    </nav>
  );
}
