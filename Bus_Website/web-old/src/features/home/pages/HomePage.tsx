import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { api } from '../../../shared/api/apiClient';

export function HomePage() {
  const [promotions, setPromotions] = useState<any[]>([]);

  useEffect(() => {
    api.get<any[]>('/promotions')
      .then(setPromotions)
      .catch(console.error);
  }, []);

  return (
    <main>
      {/* Hero Section with Search Form */}
      <section className="relative min-h-[600px] flex items-center justify-center pt-16 pb-24 px-gutter">
        <div className="absolute inset-0 z-0">
          <div className="w-full h-full bg-cover bg-center" style={{ backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuCuQtjKQfAwyWv3ZrB0uFCeSIC6oCEFLu6z19toWQWgYH2IGCHTe1hjeMIhPjj-Q5GAICfKuHkyGGVy6QTL7mai0-s8AO-nni3nd7qi9Q1czEELRRLir7RgjPZzSaFYP0xK4w7VB17-H_tO4POuWiLIPbMS2VRO2KLKYddEvxFhRLpr_bTP7PNc5_WedneZMIwKhzlOjorDQJ7bSjCLsj7o9_K-rcTKclZR8wN7F2DdDpAuGWUhLlUduQ')" }}></div>
          <div className="absolute inset-0 bg-gradient-to-b from-transparent to-surface-bright/90"></div>
        </div>
        <div className="relative z-10 w-full max-w-container-max">
          <div className="mb-12 text-center md:text-left max-w-2xl">
            <h1 className="font-headline-xl text-headline-xl text-on-surface mb-4 drop-shadow-sm">Travel Beyond Boundaries with Reliability.</h1>
            <p className="font-body-lg text-body-lg text-on-surface-variant">Experience premium intercity travel across Vietnam with Intercity Velocity's modern fleet and punctual scheduling.</p>
          </div>
          {/* Search Widget */}
          <div className="glass-panel p-6 md:p-8 rounded-xl shadow-lg w-full">
            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
              <div className="flex flex-col gap-2">
                <label className="font-label-md text-on-surface-variant flex items-center gap-1">
                  <span className="material-symbols-outlined text-primary">location_on</span> From
                </label>
                <input className="w-full bg-surface-container-lowest border-outline-variant rounded-lg p-3 text-body-md focus:border-primary-container focus:ring-primary-container" placeholder="Origin City" type="text" />
              </div>
              <div className="flex flex-col gap-2">
                <label className="font-label-md text-on-surface-variant flex items-center gap-1">
                  <span className="material-symbols-outlined text-primary">near_me</span> To
                </label>
                <input className="w-full bg-surface-container-lowest border-outline-variant rounded-lg p-3 text-body-md focus:border-primary-container focus:ring-primary-container" placeholder="Destination City" type="text" />
              </div>
              <div className="flex flex-col gap-2">
                <label className="font-label-md text-on-surface-variant flex items-center gap-1">
                  <span className="material-symbols-outlined text-primary">calendar_month</span> Date
                </label>
                <input className="w-full bg-surface-container-lowest border-outline-variant rounded-lg p-3 text-body-md focus:border-primary-container focus:ring-primary-container" type="date" />
              </div>
              <div className="flex flex-col gap-2">
                <label className="font-label-md text-on-surface-variant flex items-center gap-1">
                  <span className="material-symbols-outlined text-primary">person</span> Passengers
                </label>
                <select className="w-full bg-surface-container-lowest border-outline-variant rounded-lg p-3 text-body-md focus:border-primary-container focus:ring-primary-container">
                  <option>1 Passenger</option>
                  <option>2 Passengers</option>
                  <option>3 Passengers</option>
                  <option>4+ Passengers</option>
                </select>
              </div>
            </div>
            <div className="mt-6 flex justify-end">
              <Link to="/search">
                <button className="bg-secondary-container text-on-primary font-headline-md px-10 py-4 rounded-xl flex items-center gap-2 hover:shadow-md transition-all active:scale-95 group">
                  Search Routes
                  <span className="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
              </Link>
            </div>
          </div>
        </div>
      </section>
      {/* Latest Promotions Section */}
      <section className="py-20 px-gutter bg-surface-bright">
        <div className="max-w-container-max mx-auto">
          <div className="flex flex-col md:flex-row justify-between items-end mb-10 gap-4">
            <div>
              <span className="font-label-md text-secondary-container uppercase tracking-widest">Special Offers</span>
              <h2 className="font-headline-lg text-headline-lg text-on-surface mt-2">Latest Promotions</h2>
            </div>
            <a className="text-primary font-label-md flex items-center gap-1 hover:underline" href="#">View All Deals <span className="material-symbols-outlined">chevron_right</span></a>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {promotions.map((promo: any) => (
              <div key={promo.id} className="group relative bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm hover:shadow-md transition-all border border-outline-variant/30 flex flex-col h-full">
                <div className="relative h-48 overflow-hidden bg-primary-container flex items-center justify-center">
                  {promo.logoPath ? (
                    <img className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500" src={promo.logoPath} alt={promo.title} />
                  ) : (
                    <span className="material-symbols-outlined text-6xl text-primary opacity-50">loyalty</span>
                  )}
                  <div className="absolute top-4 left-4 bg-error-container text-on-error-container px-3 py-1 rounded-full font-label-sm font-bold">{promo.discountPct}% OFF</div>
                </div>
                <div className="p-6 flex-grow flex flex-col">
                  <h3 className="font-headline-md text-headline-md text-on-surface mb-2">{promo.title}</h3>
                  <p className="text-on-surface-variant font-body-sm mb-6">{promo.subtitle || 'Don\'t miss out on this special offer for your next trip.'}</p>
                  <div className="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center">
                    <span className="font-label-sm text-outline uppercase">
                      Code: <span className="font-bold text-on-surface">{promo.code}</span>
                    </span>
                    <button className="text-primary font-bold font-label-md flex items-center gap-1">Details <span className="material-symbols-outlined">north_east</span></button>
                  </div>
                </div>
              </div>
            ))}
            {promotions.length === 0 && (
              <div className="col-span-3 text-center py-12 text-on-surface-variant">
                No active promotions at the moment.
              </div>
            )}
          </div>
        </div>
      </section>
      {/* Popular Routes Section */}
      <section className="py-24 px-gutter bg-surface-container-low">
        <div className="max-w-container-max mx-auto">
          <div className="text-center mb-16">
            <h2 className="font-headline-lg text-headline-lg text-on-surface">Popular Direct Routes</h2>
            <p className="text-on-surface-variant max-w-xl mx-auto mt-4 font-body-md">Discover Vietnam's most scenic destinations with our high-frequency, reliable intercity network.</p>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {/* Route 1 */}
            <div className="route-card group bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm cursor-pointer">
              <div className="h-40 overflow-hidden">
                <img className="w-full h-full object-cover route-image transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAzZQkl3pVftaj15nWyy34gPlRxq6oOYKiATe4rX9siSNhA2ep5rRXN97wJjGDYlyISP2WB5dYqNGqk-JzI8GzD8mkXy6eODC2qC7XA6gZYpTW8qqhlupm1b6LELs2UxVSX9ox1d9UKHnt1dA989f56ZHfB6NBkLV8tqbVT1ETBYawzIvigPG_EYgw5twa18Bjzg4So8dDi6peGU3-J4O8sl0YMhg1RRwpaDCsa1TpBYvVM-2xmeEI9iw" />
              </div>
              <div className="p-4">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-label-md text-on-surface">Hanoi</span>
                  <span className="material-symbols-outlined text-outline text-sm">trending_flat</span>
                  <span className="font-label-md text-on-surface">Sapa</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-on-surface-variant text-body-sm italic">6h 30m</span>
                  <span className="font-headline-md text-primary">$18</span>
                </div>
              </div>
            </div>
            {/* Route 2 */}
            <div className="route-card group bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm cursor-pointer">
              <div className="h-40 overflow-hidden">
                <img className="w-full h-full object-cover route-image transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuC2AtdxLqXrG5jOYMxg38KL8mjAex-PZA_Sm0TtrJ3zhk23JGE_cnMkkJbT5S1cFWGl49Kv2uSdZV0mdmNSgyv16Vt8TdlQGpdj3C74QcEvNyl65WvgQ00k_DOcPL3XKDmxS3J9EfmQtfs1u0Y1ZUBHM_838eFywxRrNbbsHmNtd9yjmbO6uaGKGcXemm0vsddSKhplHRzj8VrftDjiGbeqOBzE886ZcUDcDXGNti7QSzmX9Agkn0RvnA" />
              </div>
              <div className="p-4">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-label-md text-on-surface">Saigon</span>
                  <span className="material-symbols-outlined text-outline text-sm">trending_flat</span>
                  <span className="font-label-md text-on-surface">Dalat</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-on-surface-variant text-body-sm italic">8h 15m</span>
                  <span className="font-headline-md text-primary">$15</span>
                </div>
              </div>
            </div>
            {/* Route 3 */}
            <div className="route-card group bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm cursor-pointer">
              <div className="h-40 overflow-hidden">
                <img className="w-full h-full object-cover route-image transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDk4hgLhPN1bpBxH9dd13KwjplPGt2bxoHvNHDCT1k3bHHdVBImgwzhsCzlocWhQbt11AxBRK1z7fAExc-XwljgN-u4JT1qF-5J6sdthYeWHHsS8RXQW9VD4C28ZEy87vpi2mPAcI5T6XsgbWLSFXIYoy1Gi3rGKLSXpnQ-oofqYmeOeaueEIXOxI6igIKz4GjFKum2pnab60u7WimTVehRGbcpwlTLF9QKol5_9UanidUTfkSAMz0ccQ" />
              </div>
              <div className="p-4">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-label-md text-on-surface">Danang</span>
                  <span className="material-symbols-outlined text-outline text-sm">trending_flat</span>
                  <span className="font-label-md text-on-surface">Hoi An</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-on-surface-variant text-body-sm italic">45m</span>
                  <span className="font-headline-md text-primary">$6</span>
                </div>
              </div>
            </div>
            {/* Route 4 */}
            <div className="route-card group bg-surface-container-lowest rounded-xl overflow-hidden shadow-sm cursor-pointer">
              <div className="h-40 overflow-hidden">
                <img className="w-full h-full object-cover route-image transition-transform duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBMA-V9N5-XqI0t649WCDQ8xDQ2xjUwqRksb_5WignRp_-CMROYkmfbMUcK4L_-j_lvWF9HuJbBkGS8Sv1i25GCMRNYI6uTHmvxw85_knImGCBP4-GfAy3M-mVnaPZ8tXy-XoNtXP1JYcHopwQ9gsS_AX4A7DOZSP7YvrvGxMvzexm3wEHHOmxamvuwMK5HUqS_9bt-rxv6qUkwme4YKl2nPYafiHA_sBeskp1ABl9Z0mI7MPeRAn-AnA" />
              </div>
              <div className="p-4">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-label-md text-on-surface">Saigon</span>
                  <span className="material-symbols-outlined text-outline text-sm">trending_flat</span>
                  <span className="font-label-md text-on-surface">Mui Ne</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-on-surface-variant text-body-sm italic">5h 00m</span>
                  <span className="font-headline-md text-primary">$12</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      {/* Features/Trust Section */}
      <section className="py-20 px-gutter bg-surface">
        <div className="max-w-container-max mx-auto grid grid-cols-1 md:grid-cols-3 gap-12">
          <div className="flex flex-col items-center text-center">
            <div className="w-16 h-16 bg-primary-fixed rounded-full flex items-center justify-center mb-6 text-primary">
              <span className="material-symbols-outlined text-[32px]">verified_user</span>
            </div>
            <h3 className="font-headline-md text-headline-md text-on-surface mb-3">Guaranteed Boarding</h3>
            <p className="text-on-surface-variant font-body-sm">Your seat is locked and guaranteed from the moment you book. No overbooking, ever.</p>
          </div>
          <div className="flex flex-col items-center text-center">
            <div className="w-16 h-16 bg-primary-fixed rounded-full flex items-center justify-center mb-6 text-primary">
              <span className="material-symbols-outlined text-[32px]">timer</span>
            </div>
            <h3 className="font-headline-md text-headline-md text-on-surface mb-3">Punctual Schedules</h3>
            <p className="text-on-surface-variant font-body-sm">We take pride in our 98% on-time arrival rate. Time is the one thing we can't get back.</p>
          </div>
          <div className="flex flex-col items-center text-center">
            <div className="w-16 h-16 bg-primary-fixed rounded-full flex items-center justify-center mb-6 text-primary">
              <span className="material-symbols-outlined text-[32px]">support_agent</span>
            </div>
            <h3 className="font-headline-md text-headline-md text-on-surface mb-3">24/7 Concierge</h3>
            <p className="text-on-surface-variant font-body-sm">Our support team is available around the clock to assist with your travel changes.</p>
          </div>
        </div>
      </section>
    </main>
  );
}
