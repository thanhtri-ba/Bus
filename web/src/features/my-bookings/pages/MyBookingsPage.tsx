import { useState, useMemo, useEffect } from 'react';
import { MyBookingsHeader } from '../components/MyBookingsHeader';
import { BookingsTabs } from '../components/BookingsTabs';
import type { TabValue } from '../components/BookingsTabs';
import { BookingCard } from '../components/BookingCard';
import { HelpSection } from '../components/HelpSection';
import { api } from '../../../shared/api/apiClient';
import type { Booking } from '../data/mockBookings';
import { useNavigate } from 'react-router-dom';

export function MyBookingsPage() {
  const [activeTab, setActiveTab] = useState<TabValue>('upcoming');
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const userStr = localStorage.getItem('user');
    if (!userStr) {
      navigate('/auth');
      return;
    }

    api.get<any>('/bookings')
      .then(res => {
        if (res.success) {
          const mappedBookings: Booking[] = res.data.map((b: any) => {
            const trip = b.tripSchedule.trip;
            const route = trip.route;
            return {
              id: b.id.substring(0, 8).toUpperCase(),
              status: b.status === 'CONFIRMED' ? 'upcoming' : b.status === 'CANCELLED' ? 'cancelled' : 'completed',
              price: new Intl.NumberFormat('vi-VN').format(b.totalAmount) + 'đ',
              className: trip.busClass,
              seatsCount: b.seatNumbers.length,
              departure: {
                time: new Date(b.tripSchedule.departureTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                city: route.departureCity.name,
                station: route.departureCity.name + ' Station',
                date: new Date(b.tripSchedule.departureTime).toLocaleDateString()
              },
              arrival: {
                time: new Date(b.tripSchedule.arrivalTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
                city: route.arrivalCity.name,
                station: route.arrivalCity.name + ' Station',
                date: new Date(b.tripSchedule.arrivalTime).toLocaleDateString()
              },
              duration: `${Math.floor(b.tripSchedule.durationMins / 60)}h ${b.tripSchedule.durationMins % 60}m`
            };
          });
          setBookings(mappedBookings);
        }
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, [navigate]);

  const upcomingCount = useMemo(() => {
    return bookings.filter(b => b.status === 'upcoming').length;
  }, [bookings]);

  const filteredBookings = useMemo(() => {
    return bookings.filter(b => b.status === activeTab);
  }, [activeTab, bookings]);

  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 min-h-screen">
      <MyBookingsHeader />
      
      <BookingsTabs 
        activeTab={activeTab} 
        onTabChange={setActiveTab} 
        upcomingCount={upcomingCount} 
      />
      
      <div className="space-y-6">
        {loading ? (
          <div className="text-center py-12 text-on-surface-variant font-label-md">
            Loading bookings...
          </div>
        ) : filteredBookings.length > 0 ? (
          filteredBookings.map(booking => (
            <BookingCard key={booking.id} booking={booking} />
          ))
        ) : (
          <div className="text-center py-12 text-on-surface-variant font-label-md">
            No bookings found for this category.
          </div>
        )}
      </div>

      <HelpSection />
    </main>
  );
}
