export function PartnerAmenities() {
  return (
    <div className="space-y-6">
      <h2 className="font-headline-md text-headline-md flex items-center gap-3">
        <span className="w-2 h-8 bg-primary rounded-full"></span>
        Onboard Amenities
      </h2>
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
        <div className="p-6 bg-surface-container-low rounded-2xl flex flex-col items-center gap-3 text-center transition-transform hover:-translate-y-1">
          <div className="w-12 h-12 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container">
            <span className="material-symbols-outlined text-3xl">wifi</span>
          </div>
          <span className="font-label-md text-label-md">Free High-Speed Wi-Fi</span>
        </div>
        <div className="p-6 bg-surface-container-low rounded-2xl flex flex-col items-center gap-3 text-center transition-transform hover:-translate-y-1">
          <div className="w-12 h-12 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container">
            <span className="material-symbols-outlined text-3xl">local_drink</span>
          </div>
          <span className="font-label-md text-label-md">Complimentary Water</span>
        </div>
        <div className="p-6 bg-surface-container-low rounded-2xl flex flex-col items-center gap-3 text-center transition-transform hover:-translate-y-1">
          <div className="w-12 h-12 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container">
            <span className="material-symbols-outlined text-3xl">dry_cleaning</span>
          </div>
          <span className="font-label-md text-label-md">Premium Cold Towels</span>
        </div>
        <div className="p-6 bg-surface-container-low rounded-2xl flex flex-col items-center gap-3 text-center transition-transform hover:-translate-y-1">
          <div className="w-12 h-12 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container">
            <span className="material-symbols-outlined text-3xl">usb</span>
          </div>
          <span className="font-label-md text-label-md">USB Charging Ports</span>
        </div>
      </div>
    </div>
  );
}
