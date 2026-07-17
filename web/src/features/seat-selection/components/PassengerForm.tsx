export function PassengerForm() {
  return (
    <div className="bg-surface-container-lowest p-8 rounded-xl custom-shadow-l2 border border-outline-variant">
      <h3 className="font-headline-md text-headline-md mb-6">Passenger Details</h3>
      <form className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="flex flex-col gap-2">
          <label className="font-label-md text-label-md text-on-surface-variant">Full Name</label>
          <input className="bg-surface p-3 rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary outline-none font-body-md text-body-md" placeholder="John Doe" type="text" />
        </div>
        <div className="flex flex-col gap-2">
          <label className="font-label-md text-label-md text-on-surface-variant">Phone Number</label>
          <input className="bg-surface p-3 rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary outline-none font-body-md text-body-md" placeholder="+1 (555) 000-0000" type="tel" />
        </div>
        <div className="flex flex-col gap-2 md:col-span-2">
          <label className="font-label-md text-label-md text-on-surface-variant">Email Address</label>
          <input className="bg-surface p-3 rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary outline-none font-body-md text-body-md" placeholder="john.doe@example.com" type="email" />
        </div>
        <div className="flex flex-col gap-2 md:col-span-2">
          <label className="font-label-md text-label-md text-on-surface-variant">Pickup Point</label>
          <select className="bg-surface p-3 rounded-lg border border-outline-variant focus:ring-2 focus:ring-primary outline-none font-body-md text-body-md">
            <option>Central Station (Main Entrance)</option>
            <option>East Side Terminal</option>
            <option>Northern Transit Hub</option>
          </select>
        </div>
      </form>
    </div>
  );
}
