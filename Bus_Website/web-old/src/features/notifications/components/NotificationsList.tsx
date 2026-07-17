import { useState } from 'react';
import { NotificationCard } from './NotificationCard';
import { SettingsDrawer } from './SettingsDrawer';

type Tab = 'all' | 'bookings' | 'promotions' | 'system';

export function NotificationsList() {
  const [activeTab, setActiveTab] = useState<Tab>('all');
  const [isSettingsOpen, setIsSettingsOpen] = useState(false);

  const notifications: React.ComponentProps<typeof NotificationCard>[] = [
    {
      id: '1',
      category: 'bookings',
      title: 'Xác nhận đặt vé thành công',
      time: '2 giờ trước',
      content: 'Chuyến đi từ Hà Nội đến Đà Nẵng (12/10/2024) của bạn đã được xác nhận. Mã đặt chỗ: #IV9921.',
      badgeLabel: 'Đặt vé',
      icon: 'directions_bus',
      isUnread: true
    },
    {
      id: '2',
      category: 'promotions',
      title: 'Ưu đãi cuối tuần: Giảm 20%',
      time: 'Hôm qua',
      content: "Nhập mã 'VELOCITY20' để nhận ngay ưu đãi giảm giá cho mọi hành trình trong cuối tuần này.",
      badgeLabel: 'Khuyến mãi',
      icon: 'sell',
      isUnread: false
    },
    {
      id: '3',
      category: 'system',
      title: 'Cập nhật chính sách bảo mật',
      time: '3 ngày trước',
      content: 'Chúng tôi vừa cập nhật Điều khoản Dịch vụ để tăng cường bảo vệ quyền lợi của bạn khi di chuyển.',
      badgeLabel: 'Hệ thống',
      icon: 'shield',
      isUnread: false
    },
    {
      id: '4',
      category: 'bookings',
      title: 'Chuyến đi đã hoàn thành',
      time: '5 ngày trước',
      content: 'Hy vọng bạn đã có một hành trình thoải mái từ Sài Gòn đi Đà Lạt. Hãy đánh giá chúng tôi nhé!',
      badgeLabel: 'Hoàn thành',
      icon: 'schedule',
      isUnread: false
    }
  ];

  const filteredNotifications = notifications.filter(
    n => activeTab === 'all' || n.category === activeTab
  );

  return (
    <section className="flex-1">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
          <h1 className="font-headline-lg text-headline-lg text-on-surface">Thông báo</h1>
          <p className="font-body-md text-body-md text-on-surface-variant">Cập nhật tin tức mới nhất về chuyến đi và ưu đãi.</p>
        </div>
        <div className="flex gap-3">
          <button className="flex items-center gap-2 px-4 py-2 text-primary font-label-md text-label-md hover:bg-primary-fixed rounded-lg transition-colors">
            <span className="material-symbols-outlined text-[18px]">done_all</span>
            Đánh dấu tất cả là đã đọc
          </button>
          <button 
            className="flex items-center gap-2 px-4 py-2 border border-outline text-on-surface-variant font-label-md text-label-md hover:bg-surface-container-high rounded-lg transition-colors"
            onClick={() => setIsSettingsOpen(true)}
          >
            <span className="material-symbols-outlined text-[18px]">tune</span>
            Cài đặt
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex border-b border-outline-variant mb-6 overflow-x-auto custom-scrollbar">
        {[
          { id: 'all', label: 'Tất cả' },
          { id: 'bookings', label: 'Chuyến đi' },
          { id: 'promotions', label: 'Khuyến mãi' },
          { id: 'system', label: 'Hệ thống' }
        ].map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id as Tab)}
            className={`px-6 py-3 border-b-2 font-label-md text-label-md whitespace-nowrap transition-colors ${
              activeTab === tab.id
                ? 'border-primary text-primary'
                : 'border-transparent text-on-surface-variant hover:text-on-surface'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Notifications List */}
      <div className="space-y-4">
        {filteredNotifications.length > 0 ? (
          filteredNotifications.map(n => <NotificationCard key={n.id} {...n} />)
        ) : (
          <div className="flex flex-col items-center justify-center py-20 text-center">
            <span className="material-symbols-outlined text-outline-variant text-[64px] mb-4">notifications_off</span>
            <h4 className="font-headline-md text-headline-md text-on-surface">Không có thông báo</h4>
            <p className="font-body-md text-body-md text-on-surface-variant">Hiện tại bạn không có thông báo nào trong mục này.</p>
          </div>
        )}
      </div>

      <SettingsDrawer isOpen={isSettingsOpen} onClose={() => setIsSettingsOpen(false)} />
    </section>
  );
}
