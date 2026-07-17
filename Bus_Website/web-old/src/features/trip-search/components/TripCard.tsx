
import { Link } from 'react-router-dom';

export interface TripAmenity {
  icon: string;
  label: string;
}

export interface TripData {
  id: string;
  operator: string;
  logo: string;
  rating: number;
  reviewCount: string;
  busType: string;
  departureTime: string;
  departureLocation: string;
  duration: string;
  routeType: string;
  arrivalTime: string;
  arrivalLocation: string;
  price: number;
  status: string;
  statusColor?: 'error' | 'tertiary';
  amenities: TripAmenity[];
  isPremium?: boolean;
}

interface TripCardProps {
  trip: TripData;
}

export function TripCard({ trip }: TripCardProps) {
  const containerClass = trip.isPremium
    ? "bg-surface-container-lowest border-2 border-primary rounded-xl overflow-hidden shadow-level-2 hover:shadow-level-3 transition-all duration-300 transform hover:-translate-y-1"
    : "bg-surface-container-lowest border border-outline-variant rounded-xl overflow-hidden shadow-level-2 hover:shadow-level-3 transition-shadow duration-300";

  return (
    <div className={containerClass}>
      {trip.isPremium && (
        <div className="bg-primary text-on-primary px-6 py-1 font-label-sm text-label-sm font-bold flex items-center gap-2">
          <span className="material-symbols-outlined text-[16px]">verified</span> PREFERRED PARTNER
        </div>
      )}
      <div className="p-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 items-center">
          {/* Bus Operator Info */}
          <div className="flex items-center gap-4">
            <div className="w-16 h-16 rounded-lg bg-surface-container flex items-center justify-center overflow-hidden">
              <img className="w-full h-full object-cover" src={trip.logo} alt={trip.operator} />
            </div>
            <div>
              <h4 className="font-headline-md text-headline-md text-on-surface">{trip.operator}</h4>
              <div className="flex items-center gap-1 text-tertiary">
                <span className="material-symbols-outlined text-[18px]" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
                <span className="font-label-md text-label-md">{trip.rating} ({trip.reviewCount})</span>
              </div>
              <span className="font-label-sm text-label-sm text-outline">{trip.busType}</span>
            </div>
          </div>
          {/* Route Timeline */}
          <div className="md:col-span-2 flex items-center justify-between px-4">
            <div className="text-center">
              <p className="font-headline-md text-headline-md text-on-surface">{trip.departureTime}</p>
              <p className="font-label-sm text-label-sm text-outline">{trip.departureLocation}</p>
            </div>
            <div className="flex-1 px-4 flex flex-col items-center">
              <p className="font-label-sm text-label-sm text-outline mb-1">{trip.duration}</p>
              <div className={`w-full h-px relative ${trip.isPremium ? 'bg-primary' : 'bg-outline-variant'}`}>
                <div className={`absolute -top-1 left-0 w-2 h-2 rounded-full ${trip.isPremium ? 'bg-primary' : 'bg-primary'}`}></div>
                <div className={`absolute -top-1 right-0 w-2 h-2 rounded-full ${trip.isPremium ? 'bg-primary' : 'bg-primary'}`}></div>
                <div className="absolute -top-3 left-1/2 -translate-x-1/2">
                  <span className="material-symbols-outlined text-primary bg-surface-container-lowest px-1">
                    {trip.isPremium ? 'rocket_launch' : 'directions_bus'}
                  </span>
                </div>
              </div>
              <p className={`font-label-sm text-label-sm mt-1 ${trip.isPremium ? 'text-primary font-bold' : 'text-tertiary'}`}>
                {trip.routeType}
              </p>
            </div>
            <div className="text-center">
              <p className="font-headline-md text-headline-md text-on-surface">{trip.arrivalTime}</p>
              <p className="font-label-sm text-label-sm text-outline">{trip.arrivalLocation}</p>
            </div>
          </div>
          {/* Price & CTA */}
          <div className="text-right flex flex-col items-end gap-2">
            <div className="text-secondary-container flex items-baseline gap-1">
              <span className="font-headline-lg text-headline-lg">{new Intl.NumberFormat('vi-VN').format(trip.price)}</span>
              <span className="font-body-sm text-body-sm underline decoration-1 underline-offset-2">đ</span>
            </div>
            <p className={`font-label-sm text-label-sm ${trip.statusColor === 'error' ? 'text-error' : 'text-tertiary'}`}>
              {trip.status}
            </p>
            <button 
              className="w-full md:w-auto bg-secondary-container text-on-primary px-10 py-3 rounded-xl font-bold hover:opacity-90 transition-all shadow-md"
              onClick={() => {
                sessionStorage.setItem('booking_tripId', trip.id);
                window.location.href = '/seat-selection';
              }}
            >
              Book Now
            </button>
          </div>
        </div>
      </div>
      {/* Amenities & Details */}
      <div className="bg-surface-container-low px-6 py-2 border-t border-outline-variant flex justify-between items-center">
        <div className="flex gap-4">
          {trip.amenities.map((amenity, idx) => (
            <span key={idx} className="flex items-center gap-1 font-label-sm text-label-sm text-outline">
              <span className="material-symbols-outlined text-[16px]">{amenity.icon}</span> {amenity.label}
            </span>
          ))}
        </div>
        <button className="text-primary font-label-md text-label-md hover:underline flex items-center gap-1">
          View Details <span className="material-symbols-outlined text-[16px]">keyboard_arrow_down</span>
        </button>
      </div>
    </div>
  );
}
