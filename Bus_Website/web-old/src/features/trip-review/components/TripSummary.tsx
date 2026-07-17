export function TripSummary() {
  return (
    <aside className="md:col-span-4 flex flex-col gap-6">
      <div className="bg-surface-container-low p-6 rounded-xl border border-outline-variant shadow-sm bento-card">
        <div className="flex items-center gap-3 mb-4">
          <div className="w-12 h-12 rounded-full bg-primary-container flex items-center justify-center text-on-primary-container">
            <span className="material-symbols-outlined">directions_bus</span>
          </div>
          <div>
            <h3 className="font-headline-md text-headline-md leading-tight">Intercity Elite</h3>
            <p className="text-on-surface-variant font-label-sm text-label-sm">Mã chuyến: #IV-88291</p>
          </div>
        </div>

        <div className="space-y-4 border-t border-outline-variant pt-4 mt-4">
          <div className="flex items-start gap-3">
            <div className="flex flex-col items-center mt-1">
              <div className="w-2 h-2 rounded-full bg-primary"></div>
              <div className="w-0.5 h-8 bg-outline-variant"></div>
              <div className="w-2 h-2 rounded-full border-2 border-primary bg-surface"></div>
            </div>
            <div className="flex flex-col gap-4">
              <div>
                <p className="font-label-md text-label-md text-on-surface">TP. Hồ Chí Minh</p>
                <p className="text-body-sm font-body-sm text-on-surface-variant">08:00 • 20 Th10, 2024</p>
              </div>
              <div>
                <p className="font-label-md text-label-md text-on-surface">Đà Lạt</p>
                <p className="text-body-sm font-body-sm text-on-surface-variant">14:30 • 20 Th10, 2024</p>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-6 pt-4 border-t border-outline-variant">
          <div className="flex justify-between items-center">
            <span className="text-body-sm font-body-sm text-on-surface-variant">Ghế của bạn:</span>
            <span className="font-label-md text-label-md text-primary">A12, A13</span>
          </div>
        </div>
      </div>

      <div className="relative rounded-xl overflow-hidden h-48 border border-outline-variant shadow-sm bento-card">
        <div 
          className="w-full h-full bg-cover bg-center" 
          style={{ backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDPDiOWKTymfR3sjl7WJ7flyLmUL_NeEDG-rVQsytcfvzVWscSvNtU4vsnko_Um3hnV7l3SVkSN4p5wCl10AyAg_-OeR00y0yPVCZGaS0tknTr07RkPNBzMXFp1jW3qZ96DeAaLrtEAxRcddmRUlZ2v9Skx6S6sMq2zovRnI8AsdxSTDgJ0mQpRaZ-l2e-Okq90WsJXE_eWOPkGRbLQPfgO3Op3LKSq8pQqJeqVQXfsvW2MA-FEMQ5iXA')" }}
        ></div>
        <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent flex items-end p-4">
          <p className="text-white font-label-md text-label-md">Hành trình 310km an toàn</p>
        </div>
      </div>
    </aside>
  );
}
