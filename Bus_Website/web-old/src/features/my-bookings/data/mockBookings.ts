export type BookingStatus = 'upcoming' | 'completed' | 'cancelled';

export interface Booking {
  id: string;
  status: BookingStatus;
  price: string;
  className: string;
  seatsCount: number;
  departure: {
    time: string;
    city: string;
    station: string;
    date: string;
  };
  arrival: {
    time: string;
    city: string;
    station: string;
    date: string;
  };
  duration: string;
}

export const mockBookings: Booking[] = [
  {
    id: 'IV-2948512',
    status: 'upcoming',
    price: '$45.00',
    className: 'Standard Class',
    seatsCount: 1,
    departure: {
      time: '08:30',
      city: 'Ho Chi Minh City',
      station: 'Mien Dong Bus Station',
      date: 'Oct 24, 2024'
    },
    arrival: {
      time: '14:45',
      city: 'Dalat City',
      station: 'Dalat Intercity Terminal',
      date: 'Oct 24, 2024'
    },
    duration: '6h 15m'
  },
  {
    id: 'IV-2955102',
    status: 'upcoming',
    price: '$32.00',
    className: 'Eco Saver',
    seatsCount: 2,
    departure: {
      time: '22:00',
      city: 'Ho Chi Minh City',
      station: 'An Suong Terminal',
      date: 'Oct 28, 2024'
    },
    arrival: {
      time: '06:00',
      city: 'Can Tho City',
      station: 'Central Can Tho Terminal',
      date: 'Oct 29, 2024'
    },
    duration: '8h 00m'
  },
  {
    id: 'IV-1822459',
    status: 'completed',
    price: '$55.00',
    className: 'Business Class',
    seatsCount: 1,
    departure: {
      time: '07:00',
      city: 'Danang City',
      station: 'Danang Central',
      date: 'Sep 15, 2024'
    },
    arrival: {
      time: '13:30',
      city: 'Hue Imperial City',
      station: 'Hue Station',
      date: 'Sep 15, 2024'
    },
    duration: '6h 30m'
  },
  {
    id: 'IV-1773004',
    status: 'cancelled',
    price: '$28.00',
    className: 'Standard Class',
    seatsCount: 1,
    departure: {
      time: '15:00',
      city: 'Hanoi',
      station: 'My Dinh Station',
      date: 'Aug 02, 2024'
    },
    arrival: {
      time: '19:15',
      city: 'Sapa',
      station: 'Sapa Express Terminal',
      date: 'Aug 02, 2024'
    },
    duration: '4h 15m'
  }
];
