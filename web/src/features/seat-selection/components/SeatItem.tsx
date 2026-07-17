export type SeatStatus = 'available' | 'selected' | 'occupied';

interface SeatItemProps {
  id: string;
  status: SeatStatus;
  onClick: (id: string) => void;
}

export function SeatItem({ id, status, onClick }: SeatItemProps) {
  if (status === 'occupied') {
    return (
      <button className="w-10 h-10 rounded-lg bg-surface-dim text-outline-variant cursor-not-allowed flex items-center justify-center font-label-sm text-label-sm overflow-hidden relative">
        {id}
        <div className="absolute w-full h-[2px] bg-outline-variant rotate-45"></div>
      </button>
    );
  }

  const isSelected = status === 'selected';
  const baseClasses = "w-10 h-10 rounded-lg border-2 border-primary transition-all flex items-center justify-center font-label-sm text-label-sm";
  const stateClasses = isSelected 
    ? "bg-primary text-white hover:opacity-90" 
    : "bg-white hover:bg-primary-fixed text-on-surface";

  return (
    <button 
      className={`${baseClasses} ${stateClasses}`}
      onClick={() => onClick(id)}
    >
      {id}
    </button>
  );
}
