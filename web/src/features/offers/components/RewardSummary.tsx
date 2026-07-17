export function RewardSummary() {
  return (
    <div className="mb-12">
      <h1 className="font-headline-lg text-headline-lg mb-6">Phần thưởng &amp; Ưu đãi của tôi</h1>
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        
        {/* Loyalty Points Card */}
        <div className="lg:col-span-2 relative overflow-hidden bg-primary-container rounded-xl p-8 text-on-primary-container card-elevation shine-anim">
          <div className="relative z-10 flex flex-col md:flex-row justify-between md:items-center gap-6">
            <div>
              <p className="font-label-md uppercase tracking-wider opacity-90 mb-2">Số dư Velocity Rewards</p>
              <div className="flex items-baseline gap-2">
                <span className="font-headline-xl text-headline-xl">2.450</span>
                <span className="font-body-lg text-body-lg opacity-80">điểm</span>
              </div>
            </div>
            <div className="flex flex-col gap-2">
              <button className="bg-surface-container-lowest text-primary px-6 py-3 rounded-lg font-label-md hover:bg-white transition-colors">Đổi quà ngay</button>
              <p className="text-sm opacity-70 italic">500 điểm sẽ hết hạn vào 31/12/2024</p>
            </div>
          </div>
          {/* Abstract Background Shape */}
          <div className="absolute -right-20 -bottom-20 w-64 h-64 bg-white/10 rounded-full blur-3xl"></div>
        </div>

        {/* Tier Progress Card */}
        <div className="bg-surface-container-lowest rounded-xl p-8 card-elevation border border-outline-variant">
          <div className="flex justify-between items-start mb-6">
            <div>
              <p className="font-label-md text-on-surface-variant mb-1">Hạng thành viên</p>
              <h3 className="font-headline-md text-headline-md text-secondary">Hạng Bạc</h3>
            </div>
            <span className="material-symbols-outlined text-secondary text-4xl" style={{ fontVariationSettings: "'FILL' 1" }}>
              workspace_premium
            </span>
          </div>
          <div className="mb-4">
            <div className="flex justify-between font-label-sm mb-2">
              <span>Tiến trình đến Hạng Vàng</span>
              <span className="font-bold text-primary">75%</span>
            </div>
            <div className="w-full bg-surface-container-high h-3 rounded-full overflow-hidden">
              <div className="tier-progress-gradient h-full rounded-full" style={{ width: '75%' }}></div>
            </div>
          </div>
          <p className="font-body-sm text-on-surface-variant">Bạn cần thêm <span className="font-bold text-on-surface">550 điểm</span> nữa để nâng cấp.</p>
        </div>

      </div>
    </div>
  );
}
