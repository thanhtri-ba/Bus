import { SeatItem, type SeatStatus } from './SeatItem';

interface SeatMapProps {
  selectedSeats: string[];
  onToggleSeat: (id: string) => void;
}

export function SeatMap({ selectedSeats, onToggleSeat }: SeatMapProps) {
  // Mock layout for demonstration. B1, B4 are occupied.
  const getStatus = (id: string): SeatStatus => {
    if (['B1', 'B4'].includes(id)) return 'occupied';
    return selectedSeats.includes(id) ? 'selected' : 'available';
  };

  return (
    <section className="lg:col-span-4 bg-surface-container-lowest p-8 rounded-xl custom-shadow-l2 border border-outline-variant">
      <div className="flex flex-col items-center">
        <h2 className="font-headline-md text-headline-md mb-6 text-center">Select Your Seats</h2>
        {/* Bus Layout Container */}
        <div className="relative bg-surface-container-low border-2 border-outline-variant rounded-[40px] px-8 py-12 w-full max-w-[280px]">
          {/* Driver Area */}
          <div className="flex justify-end mb-10 border-b border-outline-variant pb-6">
            <div className="w-10 h-10 rounded bg-outline-variant flex items-center justify-center text-on-surface-variant">
              <span className="material-symbols-outlined">sports_cricket</span>
            </div>
          </div>
          {/* Seats Grid */}
          <div className="seat-grid mx-auto">
            {/* Row 1 */}
            <SeatItem id="A1" status={getStatus('A1')} onClick={onToggleSeat} />
            <SeatItem id="A2" status={getStatus('A2')} onClick={onToggleSeat} />
            <div className="aisle"></div>
            <SeatItem id="A3" status={getStatus('A3')} onClick={onToggleSeat} />
            <SeatItem id="A4" status={getStatus('A4')} onClick={onToggleSeat} />
            {/* Row 2 */}
            <SeatItem id="B1" status={getStatus('B1')} onClick={onToggleSeat} />
            <SeatItem id="B2" status={getStatus('B2')} onClick={onToggleSeat} />
            <div className="aisle"></div>
            <SeatItem id="B3" status={getStatus('B3')} onClick={onToggleSeat} />
            <SeatItem id="B4" status={getStatus('B4')} onClick={onToggleSeat} />
            {/* Row 3 */}
            <SeatItem id="C1" status={getStatus('C1')} onClick={onToggleSeat} />
            <SeatItem id="C2" status={getStatus('C2')} onClick={onToggleSeat} />
            <div className="aisle"></div>
            <SeatItem id="C3" status={getStatus('C3')} onClick={onToggleSeat} />
            <SeatItem id="C4" status={getStatus('C4')} onClick={onToggleSeat} />
            {/* Row 4 */}
            <SeatItem id="D1" status={getStatus('D1')} onClick={onToggleSeat} />
            <SeatItem id="D2" status={getStatus('D2')} onClick={onToggleSeat} />
            <div className="aisle"></div>
            <SeatItem id="D3" status={getStatus('D3')} onClick={onToggleSeat} />
            <SeatItem id="D4" status={getStatus('D4')} onClick={onToggleSeat} />
          </div>
        </div>
        {/* Legend */}
        <div className="mt-8 grid grid-cols-2 gap-4 w-full text-label-sm font-label-sm">
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 rounded border-2 border-primary bg-white"></div>
            <span>Available</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-primary"></div>
            <span>Selected</span>
          </div>
          <div className="flex items-center gap-2">
            <div className="w-4 h-4 rounded bg-surface-dim overflow-hidden relative">
              <div className="absolute w-full h-[1px] bg-outline-variant rotate-45 top-1.5"></div>
            </div>
            <span>Occupied</span>
          </div>
        </div>
      </div>
    </section>
  );
}
