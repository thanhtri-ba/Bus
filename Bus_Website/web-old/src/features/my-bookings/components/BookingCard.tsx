import { Link } from 'react-router-dom';
import type { Booking } from '../data/mockBookings';

interface BookingCardProps {
  booking: Booking;
}

export function BookingCard({ booking }: BookingCardProps) {
  const isUpcoming = booking.status === 'upcoming';
  const isCompleted = booking.status === 'completed';
  const isCancelled = booking.status === 'cancelled';

  // Determine styles and labels based on status
  let cardClasses = 'bg-surface-container-lowest rounded-xl border transition-all duration-300';
  let statusBadgeClasses = 'px-3 py-1 rounded-full text-label-sm uppercase tracking-wider font-bold mb-2 inline-block';
  let statusLabel = '';
  
  if (isUpcoming) {
    cardClasses += ' shadow-[0px_4px_12px_rgba(0,0,0,0.05)] border-outline-variant hover:border-primary';
    statusBadgeClasses += ' bg-primary-container text-on-primary-fixed-variant';
    statusLabel = 'Confirmed';
  } else if (isCompleted) {
    cardClasses += ' shadow-none border-outline-variant opacity-75 grayscale-[0.5] hover:grayscale-0 hover:opacity-100';
    statusBadgeClasses += ' bg-surface-container-highest text-on-surface-variant';
    statusLabel = 'Completed';
  } else if (isCancelled) {
    cardClasses += ' shadow-none border-error-container opacity-80';
    statusBadgeClasses += ' bg-error-container text-on-error-container';
    statusLabel = 'Cancelled';
  }

  return (
    <div className={`booking-card group ${cardClasses} flex flex-col md:flex-row`} style={{ animation: 'fade-in 0.3s ease-out' }}>
      {/* Main Content */}
      <div className="p-6 flex-grow">
        <div className="flex flex-wrap justify-between items-start gap-4 mb-6">
          <div>
            <span className={statusBadgeClasses}>{statusLabel}</span>
            <div className="font-label-md text-on-surface-variant mt-1">
              Booking ID: <span className="font-bold text-on-surface">{booking.id}</span>
            </div>
          </div>
          <div className="text-right">
            <div className={`font-headline-md text-headline-md ${isUpcoming ? 'text-primary' : 'text-on-surface-variant'}`}>
              {booking.price}
            </div>
            {!isCompleted && (
              <div className="font-label-sm text-on-surface-variant">
                {booking.className} • {booking.seatsCount} {booking.seatsCount > 1 ? 'Seats' : 'Seat'}
              </div>
            )}
          </div>
        </div>

        {/* Route Visualizer */}
        <div className={`flex flex-col md:flex-row items-start md:items-center gap-4 md:gap-12 relative ${isCompleted ? 'opacity-80' : ''} ${isCancelled ? 'opacity-60 line-through' : ''}`}>
          {/* Departure */}
          <div className="flex-shrink-0">
            <div className="font-headline-md text-headline-md">{booking.departure.time}</div>
            <div className="font-label-md text-on-surface">{booking.departure.city}</div>
            {!isCompleted && !isCancelled && (
              <div className="font-body-sm text-on-surface-variant">{booking.departure.station}</div>
            )}
            <div className="font-label-sm text-outline mt-1">{booking.departure.date}</div>
          </div>

          {/* Visual Connector */}
          <div className={`flex flex-grow items-center justify-center w-full md:w-auto my-4 md:my-0 ${isUpcoming ? 'h-12' : ''} md:h-auto`}>
            <div className={`relative w-full h-[2px] bg-outline-variant ${isUpcoming ? 'hidden md:block' : ''}`}>
              {isUpcoming && (
                <>
                  <div className="absolute left-0 top-1/2 -translate-y-1/2 w-3 h-3 rounded-full border-2 border-primary bg-surface"></div>
                  <div className="absolute right-0 top-1/2 -translate-y-1/2 w-3 h-3 rounded-full bg-primary"></div>
                  <div className="absolute top-[-24px] left-1/2 -translate-x-1/2 flex items-center gap-2 text-on-surface-variant">
                    <span className="material-symbols-outlined text-[18px]">directions_bus</span>
                    <span className="font-label-sm">{booking.duration}</span>
                  </div>
                </>
              )}
            </div>
            {/* Mobile vertical line */}
            {isUpcoming && (
              <div className="md:hidden absolute left-4 top-1/2 -translate-y-1/2 h-20 w-[2px] bg-outline-variant"></div>
            )}
          </div>

          {/* Arrival */}
          <div className="flex-shrink-0 md:text-right">
            <div className="font-headline-md text-headline-md">{booking.arrival.time}</div>
            <div className="font-label-md text-on-surface">{booking.arrival.city}</div>
            {!isCompleted && !isCancelled && (
              <div className="font-body-sm text-on-surface-variant">{booking.arrival.station}</div>
            )}
            <div className="font-label-sm text-outline mt-1">{booking.arrival.date}</div>
          </div>
        </div>
      </div>

      {/* Right Sidebar / Action Section */}
      <div className="bg-surface-container-low p-6 md:w-64 border-t md:border-t-0 md:border-l border-outline-variant flex flex-col justify-center gap-3">
        {isUpcoming && (
          <>
            <button className="w-full bg-primary text-on-primary py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:opacity-90 transition-opacity">
              <span className="material-symbols-outlined">qr_code</span>
              Tải vé (PDF)
            </button>
            <button className="w-full border border-primary text-primary py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:bg-primary-container transition-colors">
              <span className="material-symbols-outlined">info</span>
              Xem chi tiết
            </button>
          </>
        )}
        
        {isCompleted && (
          <>
            <Link to="/trip-review" className="w-full bg-primary text-on-primary py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:opacity-90 transition-opacity">
              <span className="material-symbols-outlined">star_rate</span>
              Đánh giá
            </Link>
            <button className="w-full border border-outline text-on-surface-variant py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:bg-surface-variant">
              <span className="material-symbols-outlined">receipt_long</span>
              Hóa đơn
            </button>
            <Link to="/search" className="w-full border border-primary text-primary py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:bg-primary-container">
              <span className="material-symbols-outlined">replay</span>
              Đặt lại
            </Link>
          </>
        )}
        
        {isCancelled && (
          <>
            <div className="text-center font-label-sm text-on-error-container p-2 bg-error-container/20 rounded-md">
              Hoàn tiền đã xử lý
            </div>
            <Link to="/help" className="w-full border border-primary text-primary py-3 px-4 rounded-lg font-label-md flex items-center justify-center gap-2 hover:bg-primary-container">
              <span className="material-symbols-outlined">help</span>
              Trợ giúp
            </Link>
          </>
        )}
      </div>
    </div>
  );
}
