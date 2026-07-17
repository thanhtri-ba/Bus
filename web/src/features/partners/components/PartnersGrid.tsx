import { PartnerCard } from './PartnerCard';
import { mockPartners } from '../data/mockPartners';

export function PartnersGrid() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      {mockPartners.map((partner) => (
        <PartnerCard key={partner.id} partner={partner} />
      ))}
    </div>
  );
}
