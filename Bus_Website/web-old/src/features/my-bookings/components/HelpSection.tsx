export function HelpSection() {
  return (
    <section className="mt-16 grid grid-cols-1 md:grid-cols-3 gap-6">
      <div className="bg-primary-container text-on-primary-fixed-variant p-8 rounded-2xl flex flex-col justify-between hover:scale-[1.02] transition-transform duration-300">
        <div>
          <span className="material-symbols-outlined text-4xl mb-4">support_agent</span>
          <h3 className="font-headline-md text-headline-md mb-2">Cần hỗ trợ?</h3>
          <p className="font-body-sm">Đội ngũ hỗ trợ của chúng tôi luôn sẵn sàng 24/7 để giúp bạn với các vấn đề đặt vé.</p>
        </div>
        <a className="mt-6 font-label-md flex items-center gap-2 group" href="#">
          Liên hệ ngay 
          <span className="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
        </a>
      </div>
      <div className="bg-surface-container-high p-8 rounded-2xl md:col-span-2 flex flex-col md:flex-row gap-8 items-center border border-outline-variant">
        <div className="flex-grow">
          <h3 className="font-headline-md text-headline-md mb-4">Thay đổi hành trình?</h3>
          <p className="font-body-md text-on-surface-variant mb-6">Bạn có thể dễ dàng dời lịch hoặc hủy chuyến trực tiếp từ chi tiết vé trước 24 giờ khởi hành mà không mất phí.</p>
          <div className="flex gap-4">
            <div className="flex items-center gap-2 text-primary font-label-md">
              <span className="material-symbols-outlined">check_circle</span>
              Miễn phí hủy (24h)
            </div>
            <div className="flex items-center gap-2 text-primary font-label-md">
              <span className="material-symbols-outlined">check_circle</span>
              Đổi vé tức thì
            </div>
          </div>
        </div>
        <div className="w-48 h-48 rounded-full overflow-hidden shrink-0 border-4 border-surface shadow-lg hidden lg:block">
          <img 
            className="w-full h-full object-cover" 
            alt="Customer service" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuB313eNXF3Gl36wqKpwVxm_0Tmb1ZpbXanoHtxR2kxce-AFCRU5Cdu07dQNFx3JAgqyRQCokF_5Zot9NPf4U4h-FCIh-XCTS4v6ViXkCgth0jcnUan68ztMutovJcqilEKJhCZh-wTzaHW3Vg1T2U6CC2BUMUd0-JZQzGfi32mfSJbjw3mp_egVNoIwuT68bZyC95d0_61mn0i9sP_uiAJ1-Vpg3zdgGh7dcxQY55gPrK7oLbyVgwQk6w" 
          />
        </div>
      </div>
    </section>
  );
}
