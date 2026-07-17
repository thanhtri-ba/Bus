export function CustomerReviews() {
  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <h2 className="font-headline-md text-headline-md flex items-center gap-3">
          <span className="w-2 h-8 bg-primary rounded-full"></span>
          Customer Experience
        </h2>
        <button className="text-primary font-label-md text-label-md hover:underline">Write a Review</button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Review Card 1 */}
        <div className="p-6 bg-surface border border-outline-variant rounded-2xl space-y-4">
          <div className="flex justify-between items-start">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container font-bold">JD</div>
              <div>
                <p className="font-label-md text-label-md">John Doe</p>
                <p className="text-on-surface-variant text-[12px]">Travelled on May 15, 2024</p>
              </div>
            </div>
            <div className="flex text-secondary-container">
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
            </div>
          </div>
          <p className="text-body-sm italic">"Exceptional service. The Wi-Fi was actually fast enough to get some work done, and the seats are genuinely better than most airline economy cabins."</p>
        </div>

        {/* Review Card 2 */}
        <div className="p-6 bg-surface border border-outline-variant rounded-2xl space-y-4">
          <div className="flex justify-between items-start">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-full bg-tertiary-container flex items-center justify-center text-on-tertiary-container font-bold">AS</div>
              <div>
                <p className="font-label-md text-label-md">Alice Smith</p>
                <p className="text-on-surface-variant text-[12px]">Travelled on May 12, 2024</p>
              </div>
            </div>
            <div className="flex text-secondary-container">
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="material-symbols-outlined text-[18px]">star</span>
            </div>
          </div>
          <p className="text-body-sm italic">"Punctual departure and very clean bus. The driver was helpful with luggage. Will definitely book again for my next commute."</p>
        </div>
      </div>

      <button className="w-full py-3 border-2 border-primary text-primary rounded-xl font-label-md text-label-md hover:bg-primary-container transition-colors">
        View All 2,450 Reviews
      </button>
    </div>
  );
}
