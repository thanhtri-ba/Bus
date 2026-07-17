import { PartnerDetailsHero } from '../components/details/PartnerDetailsHero';
import { BookingShortcut } from '../components/details/BookingShortcut';
import { PartnerAmenities } from '../components/details/PartnerAmenities';
import { PopularRoutesTable } from '../components/details/PopularRoutesTable';
import { CustomerReviews } from '../components/details/CustomerReviews';
import { PartnerFAQs } from '../components/details/PartnerFAQs';
import { PartnerInfoSidebar } from '../components/details/PartnerInfoSidebar';

export function PartnerDetailsPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 space-y-12">
      {/* Hero Section */}
      <section className="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
        <PartnerDetailsHero />
        <BookingShortcut />
      </section>

      {/* Main Info Content */}
      <section className="grid grid-cols-1 lg:grid-cols-3 gap-12">
        <div className="lg:col-span-2 space-y-12">
          <PartnerAmenities />
          <PopularRoutesTable />
          <CustomerReviews />
          <PartnerFAQs />
        </div>
        
        {/* Side Sidebar: Trust & Policies */}
        <div className="lg:col-span-1">
          <PartnerInfoSidebar />
        </div>
      </section>
    </main>
  );
}
