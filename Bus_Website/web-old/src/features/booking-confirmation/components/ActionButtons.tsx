import { Link } from 'react-router-dom';

export function ActionButtons() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-4 px-8 pb-8">
      <button className="flex items-center justify-center gap-2 bg-secondary-container text-on-primary py-3 px-6 rounded-lg font-label-md hover:opacity-90 transition-all shadow-md">
        <span className="material-symbols-outlined">download</span>
        Tải vé PDF
      </button>
      <Link to="/my-bookings" className="flex items-center justify-center gap-2 border border-primary text-primary py-3 px-6 rounded-lg font-label-md hover:bg-primary-container/10 transition-all">
        <span className="material-symbols-outlined">visibility</span>
        Xem chi tiết đặt vé
      </Link>
      <Link to="/" className="flex items-center justify-center gap-2 text-on-surface-variant py-3 px-6 rounded-lg font-label-md hover:bg-surface-variant transition-all">
        <span className="material-symbols-outlined">home</span>
        Quay lại Trang chủ
      </Link>
    </div>
  );
}
