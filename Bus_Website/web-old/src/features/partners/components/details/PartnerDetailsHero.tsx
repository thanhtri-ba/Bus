export function PartnerDetailsHero() {
  return (
    <div className="lg:col-span-2 space-y-6">
      <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
          <nav className="flex items-center gap-2 text-on-surface-variant font-label-sm text-label-sm mb-2">
            <span>Operators</span>
            <span className="material-symbols-outlined text-[16px]">chevron_right</span>
            <span className="text-primary font-bold">Intercity Elite</span>
          </nav>
          <h1 className="font-headline-xl text-headline-xl text-on-surface">Intercity Elite</h1>
          <div className="flex items-center gap-4 mt-2">
            <div className="flex items-center gap-1 bg-tertiary-container text-on-tertiary-container px-3 py-1 rounded-full">
              <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="font-label-md text-label-md">4.9 / 5.0</span>
            </div>
            <span className="text-on-surface-variant font-body-sm text-body-sm">(2,450 Verified Reviews)</span>
          </div>
        </div>
        <div className="flex gap-3">
          <button className="flex items-center gap-2 border border-outline px-4 py-2 rounded-lg font-label-md text-label-md hover:bg-surface-container transition-colors">
            <span className="material-symbols-outlined">share</span>
            Share
          </button>
          <button className="flex items-center gap-2 border border-outline px-4 py-2 rounded-lg font-label-md text-label-md hover:bg-surface-container transition-colors">
            <span className="material-symbols-outlined">favorite</span>
            Save
          </button>
        </div>
      </div>

      {/* Bento Fleet Gallery */}
      <div className="grid grid-cols-4 grid-rows-2 gap-4 h-[400px]">
        <div className="col-span-2 row-span-2 relative overflow-hidden rounded-xl bg-surface-container-high group">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            alt="Premium intercity bus" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDxk_1PPaOeI9xll_TG_ARmUwSZ-qUiBj0XDr_Jl1lVng5_9zab5Nf5q5u529q6xyt7dD6QuPI1BFM6NscLZ3YIMoZsousvIQLBMdmvQlD_nkne-bXII4ik4R2nn1N8xdlsLQizJgvFriK4xy3LMhceurW-zmFmkSIZFv8bpnod6x7ZIqhnqTVNUj6zSUUQQCfR-v0kelXlAjCtGVkNt70umZGpbxRP0C-_Gz8fMPxbKzJB1yn-a4r2cQ" 
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
        </div>
        <div className="col-span-2 relative overflow-hidden rounded-xl bg-surface-container-high group">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            alt="Luxury intercity bus cabin" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBUkDaOB4HQXHaHtOe7xDRdFOmR5oUloEOAZgjiBLvRT0gUczddxCjYeq8G6REwvBtRKGO8tuOU9S-GYxwd2EkmE4gJQmxsXFheHzNGwZURfEcsHC6CCXyJZ3EdiOCRTuCoBMo7tDgCVI4SlxM_9evxQEp-t8C7yngrEp4SeVWZf-YPFr8zB3Er0KpwFKYrjP3v6deiODweHV4ZTLady18kCrMftrHTeUxtBiY0aUv6BriiDBe_0zg_fQ" 
          />
        </div>
        <div className="relative overflow-hidden rounded-xl bg-surface-container-high group">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            alt="Bus driver smiling" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBM3oswKOn4x1LPeJ0gm3XYZOcQgGjMg-s6Pb_cUdgdlBpXZiwEvPWSMdc21o177T6coyviopxxr2JtjF6xX5TAtRdGgG_Ooy3ohP7GpdWNCCbV_Ue-VA0mClDxQ-8fLhK4SP7SEv_wEp41yPbc54ZbfVUFRUgFRp4DUg6q-UKPovU6hYGdyv_VwKcoOXUO1eRpoQpwRHPflCUdJsUG6hm8qV2aSmr-X4fCVEh76yyy-Ppu2U2CUU4HcA" 
          />
        </div>
        <div className="relative overflow-hidden rounded-xl bg-surface-container-high group cursor-pointer">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105 opacity-60" 
            alt="Premium amenities" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuC-puQYNJjrPmpDxIh6bPHSQv22U4cC2vUas9DH784adSvFlCn1fGq3Ph8MSwaJUyMHTOR6Z6xK438XuVzAIJdzO25PqspN6iUtbXdVSq4oS4BQd6nMC_dc72ztYwmsN0hkQaz1SCEpW1dESeEa21e6HqXvnZ8rGUvseqC45xCEbRwzz1RqWdNCZu19lBHU5veFBJAHLqHVbXoSxB-xXMYLje7v4PiXPINqc1-khiqc6wLkVH8jAjkg-A" 
          />
          <div className="absolute inset-0 flex items-center justify-center text-on-primary font-label-md text-label-md bg-black/40">
            +12 Photos
          </div>
        </div>
      </div>
    </div>
  );
}
