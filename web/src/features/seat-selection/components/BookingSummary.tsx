import { Link } from 'react-router-dom';

interface BookingSummaryProps {
  selectedSeats: string[];
  totalPrice: number;
}

export function BookingSummary({ selectedSeats, totalPrice }: BookingSummaryProps) {
  const count = selectedSeats.length;
  const countText = count === 1 ? '1 Seat Selected' : `${count} Seats Selected`;
  const listText = count > 0 ? selectedSeats.join(', ') : 'None';
  const isDisabled = count === 0;

  return (
    <div className="bg-surface-container p-8 rounded-xl border border-primary/20 custom-shadow-l3 relative overflow-hidden">
      <div className="absolute top-0 right-0 w-32 h-32 bg-primary/5 rounded-full -mr-16 -mt-16"></div>
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 relative z-10">
        <div>
          <h4 className="font-label-md text-label-md text-primary uppercase tracking-wider mb-2">Booking Summary</h4>
          <div className="flex items-center gap-4 mb-1">
            <span className="font-headline-md text-headline-md">{countText}</span>
            <span className="text-outline">|</span>
            <span className="font-body-md text-body-md text-on-surface-variant">{listText}</span>
          </div>
          <p className="font-body-sm text-body-sm text-on-surface-variant">Trip: New York → Boston (Express 042)</p>
        </div>
        <div className="flex flex-col items-start md:items-end gap-4">
          <div className="text-right">
            <span className="font-label-sm text-label-sm text-on-surface-variant block">Total Price</span>
            <span className="font-headline-lg text-headline-lg text-secondary">{new Intl.NumberFormat('vi-VN').format(totalPrice)} đ</span>
          </div>
          <button 
            disabled={isDisabled}
            onClick={() => {
              sessionStorage.setItem('booking_seats', JSON.stringify(selectedSeats));
              sessionStorage.setItem('booking_price', totalPrice.toString());
              window.location.href = '/payment';
            }}
            className="bg-secondary-container text-on-secondary-container px-8 py-3 rounded-lg font-headline-md text-headline-md font-bold disabled:opacity-50 disabled:cursor-not-allowed hover:scale-[1.02] active:scale-[0.98] transition-all shadow-lg"
          >
            Proceed to Payment
          </button>
        </div>
      </div>
    </div>
  );
}
