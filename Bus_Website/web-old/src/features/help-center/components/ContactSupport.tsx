export function ContactSupport() {
  return (
    <section className="py-20 px-gutter max-w-container-max mx-auto">
      <div className="bg-surface-container-highest rounded-2xl p-8 md:p-12 flex flex-col md:flex-row items-center justify-between gap-8 relative overflow-hidden">
        <div className="absolute top-0 right-0 w-64 h-64 bg-primary/5 rounded-full blur-3xl -mr-32 -mt-32"></div>
        <div className="max-w-xl relative z-10">
          <h2 className="font-headline-lg text-headline-lg mb-4">Bạn vẫn cần hỗ trợ?</h2>
          <p className="text-on-surface-variant font-body-lg text-body-lg mb-8">Đội ngũ CSKH của chúng tôi luôn sẵn sàng hỗ trợ bạn 24/7 qua các kênh trực tuyến và hotline.</p>
          <div className="flex flex-wrap gap-4">
            <div className="flex items-center gap-4 bg-white p-4 rounded-xl shadow-sm border border-outline-variant">
              <div className="w-12 h-12 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                <span className="material-symbols-outlined">call</span>
              </div>
              <div>
                <p className="text-on-surface-variant font-label-sm text-label-sm">Hotline 24/7</p>
                <p className="font-headline-md text-headline-md text-primary">1900 6789</p>
              </div>
            </div>
            <div className="flex items-center gap-4 bg-white p-4 rounded-xl shadow-sm border border-outline-variant">
              <div className="w-12 h-12 rounded-lg bg-secondary-container/10 text-secondary-container flex items-center justify-center">
                <span className="material-symbols-outlined">chat</span>
              </div>
              <div>
                <p className="text-on-surface-variant font-label-sm text-label-sm">Live Chat</p>
                <p className="font-headline-md text-headline-md text-secondary-container">Chat Ngay</p>
              </div>
            </div>
          </div>
        </div>
        
        <div className="relative z-10 w-full md:w-auto">
          <div className="bg-white p-6 rounded-xl shadow-xl border border-outline-variant max-w-xs mx-auto">
            <div className="aspect-square w-full rounded-lg mb-4 overflow-hidden relative bg-surface-container">
              <img 
                className="w-full h-full object-cover" 
                alt="Customer support representative" 
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBvTzHW2UHkFDhrmBPb2sz5WOpND6jLQz7pDCAsdFI096Id20jOUxcQ_CtknA-KpV9Bxz279f_Cgga9-YbwBbOmHpJDS5YsKL2bc3gONlNcrYkzMvoOaX4-n7O4XsSsrdGGLaN9YgUpYjTG7yJ5TaBfunhoz1W0uAI1ZIhwY-zrEwcoUa2n-ih8jxIbIEOMPqG8ybjQrrOFFi9YE-yaaWEaD7U56IodbhYmPXit131hZ5H7jEfP7RAl3g" 
              />
            </div>
            <div className="flex items-center gap-3 mb-2">
              <div className="w-3 h-3 rounded-full bg-green-500 animate-pulse"></div>
              <span className="font-label-md text-label-md">Nhân viên đang trực tuyến</span>
            </div>
            <p className="font-body-sm text-body-sm text-on-surface-variant mb-4">
              Thời gian phản hồi trung bình: <span className="font-bold text-on-surface">2 phút</span>
            </p>
            <button className="w-full bg-primary text-white font-bold py-3 rounded-lg hover:bg-primary/90 transition-colors">
              Bắt đầu trò chuyện
            </button>
          </div>
        </div>
      </div>
    </section>
  );
}
