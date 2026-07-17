export function BookingShortcut() {
  return (
    <aside className="bg-surface custom-shadow-l2 border border-outline-variant p-6 rounded-xl space-y-6 lg:sticky lg:top-24">
      <div className="space-y-1">
        <p className="text-on-surface-variant font-label-sm text-label-sm uppercase tracking-wider">Starting from</p>
        <p className="font-headline-lg text-headline-lg text-secondary">$25.00</p>
      </div>

      <div className="space-y-4">
        <div className="space-y-2">
          <label className="font-label-md text-label-md">Origin</label>
          <div className="flex items-center gap-3 p-3 border border-outline-variant rounded-lg bg-surface-container-lowest">
            <span className="material-symbols-outlined text-primary">location_on</span>
            <input className="w-full border-none p-0 focus:ring-0 text-body-md bg-transparent outline-none" placeholder="Departure City" type="text" />
          </div>
        </div>

        <div className="space-y-2">
          <label className="font-label-md text-label-md">Destination</label>
          <div className="flex items-center gap-3 p-3 border border-outline-variant rounded-lg bg-surface-container-lowest">
            <span className="material-symbols-outlined text-primary">near_me</span>
            <input className="w-full border-none p-0 focus:ring-0 text-body-md bg-transparent outline-none" placeholder="Arrival City" type="text" />
          </div>
        </div>

        <button className="w-full bg-secondary-container text-on-secondary-container py-4 rounded-xl font-headline-md text-headline-md hover:brightness-95 transition-all shadow-md">
          Find Routes
        </button>
      </div>

      <div className="pt-4 border-t border-outline-variant space-y-4">
        <div className="flex items-center gap-3">
          <span className="material-symbols-outlined text-tertiary">verified_user</span>
          <span className="text-body-sm font-body-sm">Official Partner Guarantee</span>
        </div>
        <div className="flex items-center gap-3">
          <span className="material-symbols-outlined text-tertiary">event_available</span>
          <span className="text-body-sm font-body-sm">Flexible Cancellation Policy</span>
        </div>
      </div>
    </aside>
  );
}
