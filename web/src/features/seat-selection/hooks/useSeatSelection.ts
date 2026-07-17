import { useState, useCallback } from 'react';

export function useSeatSelection(seatPrice: number = 45.00, maxSeats: number = 6) {
  const [selectedSeats, setSelectedSeats] = useState<string[]>([]);

  const toggleSeat = useCallback((seatId: string) => {
    setSelectedSeats(prev => {
      const isSelected = prev.includes(seatId);
      if (isSelected) {
        return prev.filter(s => s !== seatId);
      } else {
        if (prev.length >= maxSeats) {
          alert(`Maximum ${maxSeats} seats allowed per booking.`);
          return prev;
        }
        return [...prev, seatId];
      }
    });
  }, [maxSeats]);

  const totalPrice = selectedSeats.length * seatPrice;

  return {
    selectedSeats,
    toggleSeat,
    totalPrice,
  };
}
