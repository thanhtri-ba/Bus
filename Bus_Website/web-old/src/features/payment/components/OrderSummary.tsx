export function OrderSummary() {
  return (
    <div className="lg:col-span-5 space-y-6">
      <h2 className="font-headline-md text-headline-md text-on-surface mb-4">Order Summary</h2>
      
      {/* Ticket Card */}
      <div className="bg-surface-container-lowest p-6 rounded-xl border border-outline-variant shadow-level-2">
        <div className="flex justify-between items-start mb-6">
          <div>
            <span className="bg-surface-container-highest text-primary font-label-sm px-3 py-1 rounded-full uppercase tracking-wider">Express Cruiser 402</span>
            <p className="font-body-sm text-on-surface-variant mt-2">Friday, Oct 25, 2024</p>
          </div>
          <div className="text-right">
            <p className="font-headline-md text-headline-md text-on-surface">$124.50</p>
            <p className="font-label-sm text-tertiary">All taxes included</p>
          </div>
        </div>
        
        <div className="route-line mb-6 pl-2">
          <div className="flex items-start gap-4 mb-8">
            <div className="w-4 h-4 rounded-full border-2 border-primary bg-surface mt-1 shrink-0 z-10"></div>
            <div>
              <p className="font-label-md text-on-surface leading-none">08:30 AM</p>
              <p className="font-headline-md text-headline-md text-on-surface mt-1">San Francisco</p>
              <p className="font-body-sm text-on-surface-variant">Salesforce Transit Center</p>
            </div>
          </div>
          <div className="flex items-start gap-4">
            <div className="w-4 h-4 rounded-full bg-primary mt-1 shrink-0 z-10"></div>
            <div>
              <p className="font-label-md text-on-surface leading-none">02:45 PM</p>
              <p className="font-headline-md text-headline-md text-on-surface mt-1">Los Angeles</p>
              <p className="font-body-sm text-on-surface-variant">Union Station, Bay 4</p>
            </div>
          </div>
        </div>
        
        <div className="border-t border-outline-variant pt-4 flex flex-wrap gap-4">
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-outline">airline_seat_recline_normal</span>
            <span className="font-body-sm text-on-surface">Seats: <span className="font-bold">12A, 12B</span></span>
          </div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-outline">luggage</span>
            <span className="font-body-sm text-on-surface">2 Check-in Bags</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-outline">wifi</span>
            <span className="font-body-sm text-on-surface">Free Wi-Fi</span>
          </div>
        </div>
      </div>
      
      {/* Price Breakdown */}
      <div className="bg-surface-container-low p-6 rounded-xl border border-outline-variant">
        <h3 className="font-label-md text-on-surface mb-4">Price Breakdown</h3>
        <div className="space-y-2">
          <div className="flex justify-between font-body-sm text-on-surface-variant">
            <span>Base Fare (2 Adults)</span>
            <span>$110.00</span>
          </div>
          <div className="flex justify-between font-body-sm text-on-surface-variant">
            <span>Service Fee</span>
            <span>$8.50</span>
          </div>
          <div className="flex justify-between font-body-sm text-on-surface-variant">
            <span>Insurance</span>
            <span>$6.00</span>
          </div>
          <div className="border-t border-outline-variant mt-4 pt-4 flex justify-between items-center">
            <span className="font-label-md text-on-surface">Total Amount</span>
            <span className="font-headline-md text-headline-md text-primary">$124.50</span>
          </div>
        </div>
      </div>
      
      <div className="flex items-center gap-3 p-4 bg-tertiary-container/10 border border-tertiary/20 rounded-lg">
        <span className="material-symbols-outlined text-tertiary" style={{ fontVariationSettings: "'FILL' 1" }}>verified_user</span>
        <p className="font-body-sm text-on-tertiary-fixed-variant">Price guaranteed for the next 14:59 minutes.</p>
      </div>
    </div>
  );
}
