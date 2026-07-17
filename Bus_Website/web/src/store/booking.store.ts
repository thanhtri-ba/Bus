import { create } from 'zustand';
export interface BookingSearch{departureCityId:string;arrivalCityId:string;departureDate:string;returnDate?:string;passengerCount:number}
interface BookingState{search:BookingSearch|null;selectedTripId:string|null;seatReservationId:string|null;selectedSeatIds:string[];setSearch:(search:BookingSearch)=>void;setTrip:(id:string)=>void;setReservation:(id:string,seats:string[])=>void;reset:()=>void}
const initial={search:null,selectedTripId:null,seatReservationId:null,selectedSeatIds:[]};
export const useBookingStore=create<BookingState>(set=>({...initial,setSearch:search=>set({search}),setTrip:selectedTripId=>set({selectedTripId}),setReservation:(seatReservationId,selectedSeatIds)=>set({seatReservationId,selectedSeatIds}),reset:()=>set(initial)}));
