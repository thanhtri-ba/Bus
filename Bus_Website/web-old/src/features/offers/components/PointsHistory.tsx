export function PointsHistory() {
  const historyData = [
    {
      id: 1,
      date: '12 Th09, 2024',
      title: 'Hoàn tất chuyến đi',
      subtitle: 'Hà Nội - Đà Nẵng',
      code: '#IVL-29031',
      points: '+150',
      type: 'earn',
      icon: 'add_circle',
      iconColor: 'text-tertiary',
      iconBg: 'bg-tertiary-container/20'
    },
    {
      id: 2,
      date: '05 Th09, 2024',
      title: 'Đổi mã giảm giá',
      subtitle: 'Voucher 50k - Chuyến đêm',
      code: '#IVL-00921',
      points: '-500',
      type: 'spend',
      icon: 'remove_circle',
      iconColor: 'text-error',
      iconBg: 'bg-error-container/20'
    },
    {
      id: 3,
      date: '28 Th08, 2024',
      title: 'Thưởng thăng hạng Bạc',
      subtitle: 'Cảm ơn bạn đã đồng hành',
      code: '-',
      points: '+300',
      type: 'earn',
      icon: 'stars',
      iconColor: 'text-tertiary',
      iconBg: 'bg-tertiary-container/20'
    },
    {
      id: 4,
      date: '15 Th08, 2024',
      title: 'Hoàn tất chuyến đi',
      subtitle: 'Sài Gòn - Đà Lạt',
      code: '#IVL-11029',
      points: '+80',
      type: 'earn',
      icon: 'add_circle',
      iconColor: 'text-tertiary',
      iconBg: 'bg-tertiary-container/20'
    }
  ];

  return (
    <section>
      <div className="flex items-center justify-between mb-6">
        <h2 className="font-headline-md text-headline-md">Lịch sử tích lũy &amp; Sử dụng</h2>
        <div className="flex gap-2">
          <button className="px-4 py-1 rounded-full bg-primary-container text-primary font-label-sm">Tất cả</button>
          <button className="px-4 py-1 rounded-full bg-surface-container-high text-on-surface-variant font-label-sm">Đã nhận</button>
          <button className="px-4 py-1 rounded-full bg-surface-container-high text-on-surface-variant font-label-sm">Đã dùng</button>
        </div>
      </div>

      <div className="bg-surface-container-lowest rounded-xl border border-outline-variant overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead className="bg-surface-container-low border-b border-outline-variant">
              <tr>
                <th className="px-6 py-4 font-label-md text-on-surface-variant">Ngày giao dịch</th>
                <th className="px-6 py-4 font-label-md text-on-surface-variant">Hoạt động</th>
                <th className="px-6 py-4 font-label-md text-on-surface-variant">Mã chuyến</th>
                <th className="px-6 py-4 font-label-md text-on-surface-variant text-right">Số điểm</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-outline-variant">
              {historyData.map(item => (
                <tr key={item.id} className="hover:bg-surface-container transition-colors">
                  <td className="px-6 py-4 font-body-sm">{item.date}</td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <div className={`w-8 h-8 rounded-full ${item.iconBg} ${item.iconColor} flex items-center justify-center`}>
                        <span className="material-symbols-outlined text-sm" style={{ fontVariationSettings: "'FILL' 1" }}>
                          {item.icon}
                        </span>
                      </div>
                      <div>
                        <p className="font-label-md">{item.title}</p>
                        <p className="text-xs text-on-surface-variant">{item.subtitle}</p>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 font-body-sm text-primary">{item.code}</td>
                  <td className={`px-6 py-4 text-right font-bold ${item.type === 'earn' ? 'text-tertiary' : 'text-error'}`}>
                    {item.points}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className="p-4 border-t border-outline-variant bg-surface-container-low text-center">
          <button className="text-primary font-label-md hover:underline">Xem thêm lịch sử</button>
        </div>
      </div>
    </section>
  );
}
