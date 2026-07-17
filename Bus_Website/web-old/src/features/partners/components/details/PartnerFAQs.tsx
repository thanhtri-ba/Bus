export function PartnerFAQs() {
  return (
    <div className="space-y-6">
      <h2 className="font-headline-md text-headline-md flex items-center gap-3">
        <span className="w-2 h-8 bg-primary rounded-full"></span>
        Intercity Elite FAQs
      </h2>
      <div className="space-y-4">
        <details className="group bg-surface border border-outline-variant rounded-xl [&_summary::-webkit-details-marker]:hidden">
          <summary className="flex items-center justify-between p-4 cursor-pointer">
            <h3 className="font-label-md text-label-md">What is the luggage allowance?</h3>
            <span className="material-symbols-outlined group-open:rotate-180 transition-transform">expand_more</span>
          </summary>
          <div className="px-4 pb-4 text-body-sm text-on-surface-variant">
            Intercity Elite allows one large suitcase up to 25kg to be stored in the hold and one small personal item (backpack or handbag) to be carried onboard.
          </div>
        </details>
        
        <details className="group bg-surface border border-outline-variant rounded-xl [&_summary::-webkit-details-marker]:hidden">
          <summary className="flex items-center justify-between p-4 cursor-pointer">
            <h3 className="font-label-md text-label-md">How early should I arrive at the station?</h3>
            <span className="material-symbols-outlined group-open:rotate-180 transition-transform">expand_more</span>
          </summary>
          <div className="px-4 pb-4 text-body-sm text-on-surface-variant">
            We recommend arriving at least 20 minutes before your scheduled departure time to allow for boarding and luggage handling.
          </div>
        </details>
        
        <details className="group bg-surface border border-outline-variant rounded-xl [&_summary::-webkit-details-marker]:hidden">
          <summary className="flex items-center justify-between p-4 cursor-pointer">
            <h3 className="font-label-md text-label-md">Can I change my ticket after booking?</h3>
            <span className="material-symbols-outlined group-open:rotate-180 transition-transform">expand_more</span>
          </summary>
          <div className="px-4 pb-4 text-body-sm text-on-surface-variant">
            Yes, tickets can be modified up to 12 hours before departure. A small administrative fee may apply depending on your fare type.
          </div>
        </details>
      </div>
    </div>
  );
}
