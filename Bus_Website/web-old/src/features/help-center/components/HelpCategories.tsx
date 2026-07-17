export function HelpCategories() {
  const categories = [
    {
      icon: 'payments',
      title: 'Booking & Payment',
      desc: 'Hướng dẫn đặt vé, thanh toán an toàn và quản lý mã giảm giá.'
    },
    {
      icon: 'event_busy',
      title: 'Cancellations & Refunds',
      desc: 'Quy trình hoàn tiền, phí hủy vé và các điều khoản liên quan.'
    },
    {
      icon: 'luggage',
      title: 'Luggage Policy',
      desc: 'Trọng lượng hành lý cho phép và các vật dụng bị cấm mang theo.'
    },
    {
      icon: 'loyalty',
      title: 'Loyalty Program',
      desc: 'Tích điểm đổi thưởng và các đặc quyền cho thành viên VIP.'
    }
  ];

  return (
    <section className="py-16 px-gutter max-w-container-max mx-auto">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {categories.map(cat => (
          <div key={cat.title} className="bg-surface p-8 rounded-xl border border-outline-variant shadow-sm transition-all duration-300 cursor-pointer group flex flex-col items-center text-center hover:-translate-y-1">
            <div className="w-16 h-16 rounded-full bg-surface-container-high flex items-center justify-center text-primary mb-6 group-hover:bg-primary group-hover:text-white transition-colors">
              <span className="material-symbols-outlined text-4xl" style={{ fontVariationSettings: "'FILL' 1" }}>{cat.icon}</span>
            </div>
            <h3 className="font-headline-md text-headline-md mb-2">{cat.title}</h3>
            <p className="text-on-surface-variant font-body-sm text-body-sm">{cat.desc}</p>
          </div>
        ))}
      </div>
    </section>
  );
}
