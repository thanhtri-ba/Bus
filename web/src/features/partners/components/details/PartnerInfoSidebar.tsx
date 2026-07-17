export function PartnerInfoSidebar() {
  return (
    <div className="space-y-8">
      <div className="bg-surface-container-high p-6 rounded-2xl space-y-6">
        <h3 className="font-headline-md text-headline-md">Bus Operator Info</h3>
        <div className="space-y-4">
          <div className="flex items-start gap-4">
            <span className="material-symbols-outlined text-primary">history</span>
            <div>
              <p className="font-label-md text-label-md">Operating Since</p>
              <p className="text-body-sm">2012 (12 Years)</p>
            </div>
          </div>
          <div className="flex items-start gap-4">
            <span className="material-symbols-outlined text-primary">airport_shuttle</span>
            <div>
              <p className="font-label-md text-label-md">Fleet Size</p>
              <p className="text-body-sm">85 Premium Coaches</p>
            </div>
          </div>
          <div className="flex items-start gap-4">
            <span className="material-symbols-outlined text-primary">language</span>
            <div>
              <p className="font-label-md text-label-md">Coverage</p>
              <p className="text-body-sm">15 Major Cities</p>
            </div>
          </div>
        </div>
      </div>
      
      <div className="border border-outline-variant p-6 rounded-2xl space-y-4">
        <h4 className="font-label-md text-label-md uppercase tracking-widest text-on-surface-variant">Safety First</h4>
        <ul className="space-y-3">
          <li className="flex items-center gap-2 text-body-sm">
            <span className="material-symbols-outlined text-tertiary text-sm" style={{ fontVariationSettings: "'FILL' 1" }}>check_circle</span>
            GPS Tracking Enabled
          </li>
          <li className="flex items-center gap-2 text-body-sm">
            <span className="material-symbols-outlined text-tertiary text-sm" style={{ fontVariationSettings: "'FILL' 1" }}>check_circle</span>
            CCTV Surveillance
          </li>
          <li className="flex items-center gap-2 text-body-sm">
            <span className="material-symbols-outlined text-tertiary text-sm" style={{ fontVariationSettings: "'FILL' 1" }}>check_circle</span>
            Regular Maintenance Checks
          </li>
        </ul>
      </div>
      
      <div className="relative rounded-2xl overflow-hidden h-48 group">
        <div className="absolute inset-0 bg-black/30 group-hover:bg-black/20 transition-colors z-10 flex items-center justify-center">
          <button className="bg-surface text-on-surface px-6 py-2 rounded-full font-label-md text-label-md flex items-center gap-2">
            <span className="material-symbols-outlined">map</span>
            View Station Map
          </button>
        </div>
        <div 
          className="w-full h-full bg-cover bg-center" 
          style={{ backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBu_qYt4O4dEV0bAQj9KNYDLzzreBCWP2YwxPQoogT4eUgK74kfxmwQVm5Y_XUkLL4Ap4HJaAU0la8gC0M8EBZMS9bBTlHiFCzwzFZgh-lQOjqU7asVb6YquA9q-x1Sa5Edog26DWvPgF7sC8dBEYvSGsK4_BWdBjfE4QYLY1Y-jZowlfpdLaES2JXWcCJCg2MPdNV8n3FDqxUtrNOWCCSwqj4z6vpFMc7L0rqzoSWUvph_TsquVxDNHQ')" }}
        ></div>
      </div>
    </div>
  );
}
