import { useEffect, useRef } from 'react';

export function NewsGrid() {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const observerOptions = {
      threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('opacity-100', 'translate-y-0');
          entry.target.classList.remove('opacity-0', 'translate-y-8');
        }
      });
    }, observerOptions);

    if (containerRef.current) {
      const elements = containerRef.current.querySelectorAll('.reveal-card');
      elements.forEach(el => observer.observe(el));
    }

    return () => observer.disconnect();
  }, []);

  return (
    <section ref={containerRef} className="grid grid-cols-1 md:grid-cols-12 gap-8">
      {/* Promotion Card Large */}
      <div className="reveal-card md:col-span-8 group bg-white rounded-xl overflow-hidden custom-shadow hover:shadow-lg transition-all duration-700 opacity-0 translate-y-8 border border-[#E2E8F0]">
        <div className="flex flex-col md:flex-row h-full">
          <div className="md:w-1/2 overflow-hidden h-64 md:h-full relative">
            <img 
              className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuBCq0H2FQmjUtlCOf3HT2-HZe0-dc36SHo2YiPGEbKZ2iWJ_kIuZtdlqeamj8lHoSLSxxUBPpox6vON8GzyZx2bsZ6LzD9LbpOUXhMxKKmQOm1kiFmQFre4qeADCWKcnlw29rVCJrrK5UaFOC0G6PQk_2ruNJ1Cf5z6OxPUNeEuTD_VwC8559Kh4RjY6CSPkHeDE9e4T5dkqYuSgNnZ2hj0woForA3ijtKcRYBRF6brZYvJXBzWX8Sjkw" 
              alt="Food Tour Đà Lạt" 
            />
            <span className="absolute top-4 left-4 bg-tertiary-container text-on-tertiary-container px-3 py-1 rounded font-label-sm">Khuyến Mãi</span>
          </div>
          <div className="md:w-1/2 p-8 flex flex-col justify-between">
            <div className="space-y-4">
              <h3 className="font-headline-md text-headline-md group-hover:text-primary transition-colors">Food Tour Đà Lạt cùng Intercity - Giảm 15% gói combo</h3>
              <p className="text-on-surface-variant font-body-md line-clamp-2">
                Khám phá thiên đường ẩm thực Đà Lạt chưa bao giờ dễ dàng và tiết kiệm đến thế. Ưu đãi áp dụng cho các tuyến khởi hành từ Sài Gòn.
              </p>
            </div>
            <div className="flex items-center justify-between mt-6 pt-6 border-t border-outline-variant/30">
              <span className="text-on-surface-variant font-label-sm flex items-center gap-1">
                <span className="material-symbols-outlined text-[18px]">calendar_month</span> 12/06 - 30/06
              </span>
              <a className="text-primary font-bold hover:underline flex items-center gap-1" href="#">
                Xem chi tiết <span className="material-symbols-outlined text-[18px]">chevron_right</span>
              </a>
            </div>
          </div>
        </div>
      </div>

      {/* News Card Small 1 */}
      <div className="reveal-card md:col-span-4 group bg-white rounded-xl overflow-hidden custom-shadow hover:shadow-lg transition-all duration-700 opacity-0 translate-y-8 border border-[#E2E8F0]">
        <div className="h-48 overflow-hidden relative">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDT_y0UdA1Atuub0FjEsNVhOd74X9hTaIn1YydqamosbEgKRW_rFwjnprQg1wt25q5i5mjYmxSPCvUoROBdoqF3rLcPB4dwUtUl33YOxFWuMjCWd6_fyqr5qm_6QkG3xk_QUrHDr9A7RkMr1bt39PDSaRshUCfT0UoMCNSzNvG-EpDQIvhmsaWULQ3AyFfYqATaegHax_2uuoXI81O5bXdh5CVedn1hpAU5Uj0iGye_hHHBqybpAEX5nA" 
            alt="Trạm dừng nghỉ 5 sao" 
          />
          <span className="absolute top-4 left-4 bg-surface-container-highest text-on-surface px-3 py-1 rounded font-label-sm">Tin Tức</span>
        </div>
        <div className="p-6 space-y-3">
          <h3 className="font-headline-md text-headline-md leading-snug group-hover:text-primary transition-colors">Vận hành trạm dừng nghỉ 5 sao mới tại Bình Thuận</h3>
          <p className="text-on-surface-variant font-body-sm line-clamp-2">Nâng tầm trải nghiệm hành khách với hệ thống tiện ích hiện đại, khu vệ sinh sạch sẽ và ẩm thực địa phương đặc sắc.</p>
          <a className="inline-flex items-center text-primary font-bold mt-2 text-label-md" href="#">Đọc thêm</a>
        </div>
      </div>

      {/* News Card Small 2 */}
      <div className="reveal-card md:col-span-4 group bg-white rounded-xl overflow-hidden custom-shadow hover:shadow-lg transition-all duration-700 opacity-0 translate-y-8 border border-[#E2E8F0]">
        <div className="h-48 overflow-hidden relative">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuCwbZ3ytJhYqbphFT8H2RJfUwHRDcBGQN9XumHUIgphzN5muKc5KY59cLe_dmqaQbe9RqtmMcF8PwCzEal0KSQADdWr13i0THOg2qGoT-9qVAC3KzjnFAq0qfl-gjxq8_-reRmB0Swktwo-U1Y1-Ko7eINcuLcuP68GQ0S5Pt71gIOlNu-7IAocm3t9lR5U-MkcjuqdY53ldwC4el7saiL3mgSGmb4jtLIxALMw6j2CeLyS7LQwJpbmeg" 
            alt="Hành lý du lịch" 
          />
          <span className="absolute top-4 left-4 bg-secondary-container/20 text-on-secondary-container px-3 py-1 rounded font-label-sm">Cẩm Nang</span>
        </div>
        <div className="p-6 space-y-3">
          <h3 className="font-headline-md text-headline-md leading-snug group-hover:text-primary transition-colors">5 Mẹo chuẩn bị hành lý cho chuyến đi dài</h3>
          <p className="text-on-surface-variant font-body-sm line-clamp-2">Làm thế nào để gói gọn đồ đạc mà vẫn đầy đủ tiện nghi? Xem ngay các gợi ý từ chuyên gia du lịch của Velocity.</p>
          <a className="inline-flex items-center text-primary font-bold mt-2 text-label-md" href="#">Đọc thêm</a>
        </div>
      </div>

      {/* Promo Card Vertical */}
      <div className="reveal-card md:col-span-4 group bg-[#004BCA] text-on-primary rounded-xl overflow-hidden custom-shadow flex flex-col justify-between transition-all duration-700 opacity-0 translate-y-8">
        <div className="p-8 space-y-4">
          <span className="material-symbols-outlined text-4xl opacity-50">redeem</span>
          <h3 className="font-headline-lg text-headline-lg-mobile md:text-headline-md">Tặng ngay voucher 50k khi giới thiệu bạn mới</h3>
          <p className="opacity-80 font-body-md">Chia sẻ mã giới thiệu của bạn cho bạn bè và cùng nhận quà từ Intercity Velocity.</p>
          <div className="pt-4">
            <div className="bg-white/10 rounded-lg p-4 border border-white/20 text-center">
              <span className="block text-xs uppercase tracking-widest opacity-60 mb-1">Mã của bạn</span>
              <span className="text-2xl font-bold tracking-tighter">SHARE50VEL</span>
            </div>
          </div>
        </div>
        <button className="w-full py-4 bg-white/10 hover:bg-white/20 font-bold border-t border-white/10 transition-colors">Sao chép mã</button>
      </div>

      {/* Experience Card */}
      <div className="reveal-card md:col-span-4 group bg-white rounded-xl overflow-hidden custom-shadow hover:shadow-lg transition-all duration-700 opacity-0 translate-y-8 border border-[#E2E8F0]">
        <div className="h-48 overflow-hidden relative">
          <img 
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuBYlAxWxxiAPNK6ZXkxVef2y-ebFEV9zFItCt3oS-L6397zlMcoK_gPz31Z5RDGPXsszDyp0PEfBwU2kBHIKwgdlhf-PzOn7J6Ax9n3JVaWAt1PD8Vd_ALrUP6gGgxIuHqqCWi0aL9qQbQDDprTlggJypungc5mxPTtraNOWy6T_xrnCFyCY-OG4Di0uKGs8CcvV6CHAYnilgZ8JXSHR8F8lNItx33P_Ezwr4EKSkm_CZ1x4nWWAYr_aA" 
            alt="Du lịch Miền Tây" 
          />
          <span className="absolute top-4 left-4 bg-secondary-container/20 text-on-secondary-container px-3 py-1 rounded font-label-sm">Trải Nghiệm</span>
        </div>
        <div className="p-6 space-y-3">
          <h3 className="font-headline-md text-headline-md leading-snug group-hover:text-primary transition-colors">Hành trình khám phá Miền Tây sông nước</h3>
          <p className="text-on-surface-variant font-body-sm line-clamp-2">Lịch trình 3 ngày 2 đêm gợi ý cho những ai yêu thích vẻ đẹp mộc mạc và thanh bình của vùng đất Cửu Long.</p>
          <a className="inline-flex items-center text-primary font-bold mt-2 text-label-md" href="#">Đọc thêm</a>
        </div>
      </div>
    </section>
  );
}
