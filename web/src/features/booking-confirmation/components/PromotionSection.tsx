export function PromotionSection() {
  return (
    <div className="mt-8 grid grid-cols-1 md:grid-cols-2 gap-4">
      <div className="bg-primary-container text-on-primary-container p-6 rounded-xl flex items-center gap-6 cursor-pointer hover:shadow-lg transition-all group">
        <div className="p-3 bg-white/20 rounded-lg group-hover:scale-110 transition-transform">
          <span className="material-symbols-outlined text-4xl">smartphone</span>
        </div>
        <div>
          <p className="font-headline-md text-headline-md">Tải ứng dụng mobile</p>
          <p className="text-body-sm opacity-80">Quản lý vé dễ dàng mọi lúc mọi nơi</p>
        </div>
      </div>
      <div className="bg-surface-container-high p-6 rounded-xl flex items-center gap-6 border border-outline-variant cursor-pointer hover:shadow-lg transition-all group">
        <div className="p-3 bg-primary/10 rounded-lg group-hover:scale-110 transition-transform">
          <span className="material-symbols-outlined text-primary text-4xl">loyalty</span>
        </div>
        <div>
          <p className="font-headline-md text-headline-md">Nhận ưu đãi 20%</p>
          <p className="text-body-sm text-on-surface-variant">Cho lượt đặt vé tiếp theo của bạn</p>
        </div>
      </div>
    </div>
  );
}
