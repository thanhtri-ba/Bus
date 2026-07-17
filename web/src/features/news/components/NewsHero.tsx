export function NewsHero() {
  return (
    <section className="relative rounded-xl overflow-hidden min-h-[400px] flex items-center group">
      <div className="absolute inset-0 z-0">
        <div 
          className="w-full h-full bg-cover bg-center transition-transform duration-700 group-hover:scale-105" 
          style={{ backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuDn0Dps3oLpaYK6a_p7C7fC3rhgK6Tio5AEDw515VdvPyPqL5omZsqqvP2_JAOO3-fPp4NHxLOtah8sKfP-f3xJUkjP4wwHwGUvNcPhwwPBqro9JYw6RRNKhrpv7540vTqAunjl69TNsDMn5d_3uhJbG1CDOS86K5KoteA6uZTLPZcwdKjYEmFutypb_SxHBXAPoTxK3lO8vyJBycp2EDGW3PiNOWaWPYNJoBrDFXKeBe7Uh2bVvjUd9A')" }}
        >
        </div>
        <div className="absolute inset-0 hero-gradient"></div>
      </div>
      <div className="relative z-10 w-full md:w-2/3 lg:w-1/2 p-8 md:p-12 text-on-primary space-y-6">
        <div className="inline-flex items-center gap-2 px-3 py-1 bg-secondary-container text-on-secondary rounded-full font-label-sm uppercase tracking-wider">
          <span className="material-symbols-outlined text-[16px]">local_fire_department</span>
          Ưu đãi Hot nhất
        </div>
        <h1 className="font-headline-xl text-headline-xl leading-tight">Chào Hè Rực Rỡ: Giảm ngay 30% vé đi biển</h1>
        <p className="font-body-lg text-body-lg text-on-primary-container/90">
          Đừng bỏ lỡ cơ hội khám phá những cung đường biển đẹp nhất Việt Nam với giá ưu đãi cực sốc dành riêng cho thành viên Velocity.
        </p>
        <div className="flex flex-wrap gap-4 pt-4">
          <button className="bg-[#FF6B00] hover:bg-[#E66000] text-white font-bold px-8 py-3 rounded-lg flex items-center gap-2 transition-all">
            Đặt vé ngay
            <span className="material-symbols-outlined">arrow_forward</span>
          </button>
          <div className="glass-effect rounded-lg px-6 py-3 flex flex-col justify-center border border-white/20 text-primary">
            <span className="text-xs font-bold uppercase">Mã code</span>
            <span className="font-bold text-lg">VELOCITYSUMMER</span>
          </div>
        </div>
      </div>
    </section>
  );
}
