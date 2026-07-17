import { useState, useEffect } from 'react';
import { TripCard, type TripData } from './TripCard';
import { api } from '../../../shared/api/apiClient';

export function TripList() {
  const [trips, setTrips] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [total, setTotal] = useState(0);

  useEffect(() => {
    api.get<any>('/trips')
      .then(res => {
        setTrips(res.data);
        setTotal(res.total);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  return (
    <div className="lg:col-span-3 space-y-6">
      <div className="flex items-center justify-between mb-2">
        <h1 className="font-headline-md text-headline-md text-on-surface">
          {loading ? 'Searching...' : `${total} Buses Found`}
        </h1>
        <div className="flex items-center gap-2">
          <span className="text-label-md font-label-md text-outline">Sort by:</span>
          <select className="border-none bg-transparent font-label-md text-primary focus:ring-0 cursor-pointer">
            <option>Earliest Departure</option>
            <option>Lowest Price</option>
            <option>Top Rated</option>
          </select>
        </div>
      </div>
      
      {loading ? (
        <div className="text-center py-12">Loading trips...</div>
      ) : trips.length > 0 ? (
        trips.map(tripData => {
          const trip = tripData.trip;
          const route = trip.route;
          const mappedTrip: TripData = {
            id: tripData.id,
            operator: trip.busAgent.name,
            logo: trip.busAgent.logo || 'https://ui-avatars.com/api/?name=' + trip.busAgent.name,
            rating: trip.busAgent.rating,
            reviewCount: `${trip.busAgent.reviewCount}`,
            busType: trip.busClass,
            departureTime: new Date(tripData.departureTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
            departureLocation: route.departureCity.name,
            duration: `${Math.floor(tripData.durationMins / 60)}h ${tripData.durationMins % 60}m`,
            routeType: route.isPopular ? 'Express Route' : 'Direct',
            arrivalTime: new Date(tripData.arrivalTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
            arrivalLocation: route.arrivalCity.name,
            price: tripData.prices[0]?.price || 0,
            status: 'High Availability',
            statusColor: 'tertiary',
            amenities: [
              { icon: 'wifi', label: 'Wifi' },
              { icon: 'local_drink', label: 'Water' }
            ],
            isPremium: trip.busAgent.rating >= 4.8
          };
          return <TripCard key={mappedTrip.id} trip={mappedTrip} />;
        })
      ) : (
        <div className="text-center py-12 text-on-surface-variant">No trips found.</div>
      )}

      {/* Load More / Pagination */}
      {!loading && trips.length < total && (
        <div className="flex justify-center pt-8">
          <button className="bg-surface text-primary border border-primary px-12 py-3 rounded-xl font-bold hover:bg-primary-fixed transition-all">
            Load More Results
          </button>
        </div>
      )}
    </div>
  );
}
