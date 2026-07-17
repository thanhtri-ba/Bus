import { SeatMap } from '../components/SeatMap';
import { PassengerForm } from '../components/PassengerForm';
import { BookingSummary } from '../components/BookingSummary';
import { useSeatSelection } from '../hooks/useSeatSelection';
import { StepIndicator } from '../../../shared/components/StepIndicator';

export function SeatSelectionPage() {
  const { selectedSeats, toggleSeat, totalPrice } = useSeatSelection();

  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 md:py-12">
      <StepIndicator />
      
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
        <SeatMap selectedSeats={selectedSeats} onToggleSeat={toggleSeat} />
        
        <section className="lg:col-span-8 flex flex-col gap-8">
          <PassengerForm />
          <BookingSummary selectedSeats={selectedSeats} totalPrice={totalPrice} />
        </section>
      </div>
    </main>
  );
}
