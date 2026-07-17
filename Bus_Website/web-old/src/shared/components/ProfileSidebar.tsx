import { Link, useLocation } from 'react-router-dom';

export function ProfileSidebar() {
  const location = useLocation();

  const getLinkClasses = (path: string) => {
    const isActive = location.pathname.startsWith(path);
    if (isActive) {
      return "flex items-center gap-3 px-4 py-3 rounded-lg bg-primary-container text-on-primary-container";
    }
    return "flex items-center gap-3 px-4 py-3 rounded-lg text-on-surface-variant hover:bg-surface-container transition-colors";
  };

  return (
    <aside className="w-full md:w-64 space-y-2 shrink-0">
      <div className="p-4 bg-surface-container-low rounded-xl mb-6">
        <div className="flex items-center gap-4 mb-4">
          <div className="w-12 h-12 rounded-full bg-primary-fixed flex items-center justify-center text-primary font-bold">
            NV
          </div>
          <div>
            <p className="font-label-md text-label-md text-on-surface">Nguyễn Văn A</p>
            <p className="font-body-sm text-body-sm text-on-surface-variant">Thành viên Bạc</p>
          </div>
        </div>
      </div>
      <nav className="space-y-1">
        <Link to="/profile" className={getLinkClasses('/profile')}>
          <span className="material-symbols-outlined">person</span>
          <span className="font-label-md text-label-md">Hồ sơ của tôi</span>
        </Link>
        <Link to="/notifications" className={getLinkClasses('/notifications')}>
          <span className="material-symbols-outlined">notifications</span>
          <span className="font-label-md text-label-md">Thông báo</span>
        </Link>
        <Link to="/my-bookings" className={getLinkClasses('/my-bookings')}>
          <span className="material-symbols-outlined">confirmation_number</span>
          <span className="font-label-md text-label-md">Chuyến đi của tôi</span>
        </Link>
        <Link to="/settings" className={getLinkClasses('/settings')}>
          <span className="material-symbols-outlined">settings</span>
          <span className="font-label-md text-label-md">Cài đặt</span>
        </Link>
      </nav>
    </aside>
  );
}
