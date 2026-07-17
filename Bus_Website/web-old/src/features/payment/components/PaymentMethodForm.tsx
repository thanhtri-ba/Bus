import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { api } from '../../../shared/api/apiClient';

export function PaymentMethodForm() {
  const [paymentMethod, setPaymentMethod] = useState('card');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handlePaymentMethodChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPaymentMethod(e.target.value);
  };

  const handlePaymentSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    const tripId = sessionStorage.getItem('booking_tripId');
    const seatsStr = sessionStorage.getItem('booking_seats');
    
    if (!tripId || !seatsStr) {
      setError('Missing booking information. Please start over.');
      setLoading(false);
      return;
    }

    let seats = [];
    try {
      seats = JSON.parse(seatsStr);
    } catch {
      seats = [];
    }

    try {
      const res = await api.post('/bookings/create', {
        tripScheduleId: tripId,
        seatNumbers: seats,
        passengers: seats.map((seat: string, idx: number) => ({
          name: `Passenger ${idx + 1}`
        }))
      });
      sessionStorage.removeItem('booking_tripId');
      sessionStorage.removeItem('booking_seats');
      sessionStorage.removeItem('booking_price');
      navigate('/booking-confirmation');
    } catch (err: any) {
      setError(err.message || 'Failed to create booking.');
      setLoading(false);
    }
  };

  const isCard = paymentMethod === 'card';

  return (
    <div className="lg:col-span-7">
      <h2 className="font-headline-md text-headline-md text-on-surface mb-6">Payment Method</h2>
      <form className="space-y-6" onSubmit={handlePaymentSubmit}>
        {/* Method Selectors */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
          <label className="cursor-pointer">
            <input 
              checked={paymentMethod === 'card'} 
              className="peer sr-only" 
              name="payment_method" 
              type="radio" 
              value="card" 
              onChange={handlePaymentMethodChange}
            />
            <div className="flex flex-col items-center justify-center p-4 border border-outline-variant rounded-xl peer-checked:border-primary peer-checked:bg-primary-fixed/30 transition-all hover:bg-surface-container">
              <span className="material-symbols-outlined text-primary mb-2">credit_card</span>
              <span className="font-label-md">Credit Card</span>
            </div>
          </label>
          <label className="cursor-pointer">
            <input 
              checked={paymentMethod === 'wallet'}
              className="peer sr-only" 
              name="payment_method" 
              type="radio" 
              value="wallet" 
              onChange={handlePaymentMethodChange}
            />
            <div className="flex flex-col items-center justify-center p-4 border border-outline-variant rounded-xl peer-checked:border-primary peer-checked:bg-primary-fixed/30 transition-all hover:bg-surface-container">
              <span className="material-symbols-outlined text-primary mb-2">account_balance_wallet</span>
              <span className="font-label-md">E-wallet</span>
            </div>
          </label>
          <label className="cursor-pointer">
            <input 
              checked={paymentMethod === 'bank'}
              className="peer sr-only" 
              name="payment_method" 
              type="radio" 
              value="bank" 
              onChange={handlePaymentMethodChange}
            />
            <div className="flex flex-col items-center justify-center p-4 border border-outline-variant rounded-xl peer-checked:border-primary peer-checked:bg-primary-fixed/30 transition-all hover:bg-surface-container">
              <span className="material-symbols-outlined text-primary mb-2">account_balance</span>
              <span className="font-label-md">Bank Transfer</span>
            </div>
          </label>
        </div>
        
        {/* Card Details Form */}
        <div 
          className={`bg-surface-container-lowest p-6 md:p-8 rounded-xl border border-outline-variant shadow-level-2 space-y-4 transition-all duration-300 ${!isCard ? 'opacity-50 pointer-events-none grayscale' : ''}`}
        >
          <div className="flex justify-between items-center mb-2">
            <h3 className="font-label-md text-on-surface">Card Information</h3>
            <div className="flex gap-2">
              <img alt="Visa" className="h-4 opacity-70" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDfyBvDR4wz_SNQ9MWz9cPtVwhT3nAyh7APsZDaQsMQEG7fT-W9Cv413kXrk0naNDPlh0ggSLnxFfAfIdQDQsCBhZh5EZZTwG58RQKrCpbtraOEqyZdvU2VKCESVdX7bsHDuyx732FoN9Ak8PedISqwQwXX5frGGeQHzxhwNYl_R0r1ypteNn0eQP4xRrgGpfCb-okxv0LE5pPRbo86jQcJKnGUg_EGzSonuSXgD66-6H2bdBghYxxYMQ" />
              <img alt="Mastercard" className="h-4 opacity-70" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAojo-mtzsp3D9EiTCrPEs0-kUvFmN_4ts9llEYGOtSAGuj4JtQQinzW-rXF2NDhw9yoMJOc65eYtXiQx9geliaEuqDUOR7ir_tXKLpVq3fli9FUgTv3X0iGeNBiJtS7dgZW8ZIKTgzSKRWwgnPzYimmdxzJMFWvyEe2sX3mABAwczLpw2V7IIVZcJ7J3ojShjVBYpUYNMIKzHR9p3_VTPp62LPqnnYxUtqXvcL2NWiJVFvcFhMPuaRCg" />
            </div>
          </div>
          <div className="space-y-4">
            <div>
              <label className="block font-label-sm text-outline mb-1.5">Cardholder Name</label>
              <input className="w-full border-outline-variant rounded-lg p-3 text-on-surface focus:ring-primary focus:border-primary outline-none" placeholder="John Doe" type="text" />
            </div>
            <div>
              <label className="block font-label-sm text-outline mb-1.5">Card Number</label>
              <div className="relative">
                <input className="w-full border-outline-variant rounded-lg p-3 pl-4 pr-12 text-on-surface focus:ring-primary focus:border-primary outline-none" placeholder="0000 0000 0000 0000" type="text" />
                <span className="material-symbols-outlined absolute right-3 top-3 text-outline">lock</span>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block font-label-sm text-outline mb-1.5">Expiry Date</label>
                <input className="w-full border-outline-variant rounded-lg p-3 text-on-surface focus:ring-primary focus:border-primary outline-none" placeholder="MM/YY" type="text" />
              </div>
              <div>
                <label className="block font-label-sm text-outline mb-1.5">CVV / CVC</label>
                <input className="w-full border-outline-variant rounded-lg p-3 text-on-surface focus:ring-primary focus:border-primary outline-none" placeholder="123" type="text" />
              </div>
            </div>
          </div>
          <div className="flex items-center gap-2 mt-4">
            <input className="rounded text-primary focus:ring-primary h-4 w-4" id="save-card" type="checkbox" />
            <label className="font-body-sm text-on-surface-variant cursor-pointer" htmlFor="save-card">Save card details for future bookings</label>
          </div>
        </div>
        
        {/* Promo Code */}
        <div className="flex items-end gap-3">
          <div className="flex-grow">
            <label className="block font-label-sm text-outline mb-1.5">Promo Code</label>
            <input className="w-full border-outline-variant rounded-lg p-3 text-on-surface focus:ring-primary focus:border-primary outline-none" placeholder="Enter code" type="text" />
          </div>
          <button className="bg-surface-container-high text-on-surface px-6 py-3 rounded-lg font-label-md hover:bg-surface-variant transition-colors h-[48px]" type="button">Apply</button>
        </div>
        
        {/* Action Button */}
        <div className="space-y-4 pt-4">
          {error && (
            <div className="p-3 bg-error-container text-on-error-container rounded-lg font-label-sm">
              {error}
            </div>
          )}
          <button 
            className="w-full bg-secondary-container text-on-primary font-headline-md py-4 rounded-xl shadow-lg hover:opacity-90 active:scale-[0.99] transition-all flex items-center justify-center gap-2 disabled:opacity-70" 
            type="submit"
            disabled={loading}
          >
            {loading ? <span className="material-symbols-outlined animate-spin">sync</span> : null}
            <span>{loading ? 'Processing...' : `Confirm & Pay ${sessionStorage.getItem('booking_price') ? new Intl.NumberFormat('vi-VN').format(Number(sessionStorage.getItem('booking_price'))) + 'đ' : ''}`}</span>
            {!loading && <span className="material-symbols-outlined">arrow_forward</span>}
          </button>
          <p className="text-center font-body-sm text-outline px-4">
            By clicking Confirm & Pay, you agree to Intercity Velocity's 
            <a className="text-primary underline mx-1" href="#">Terms of Service</a> and 
            <a className="text-primary underline ml-1" href="#">Privacy Policy</a>.
          </p>
        </div>
        
        {/* Trust Indicators */}
        <div className="border-t border-outline-variant pt-8 mt-8 flex flex-wrap justify-center items-center gap-8 md:gap-12 opacity-60">
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-on-surface-variant">security</span>
            <span className="font-label-sm uppercase tracking-widest">SSL Secured</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-on-surface-variant">verified</span>
            <span className="font-label-sm uppercase tracking-widest">PCI Compliant</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="material-symbols-outlined text-on-surface-variant">thumb_up</span>
            <span className="font-label-sm uppercase tracking-widest">Travel Guard</span>
          </div>
        </div>
      </form>
    </div>
  );
}
