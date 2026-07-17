import { Link } from 'react-router-dom';
import type { Partner } from '../data/mockPartners';

interface PartnerCardProps {
  partner: Partner;
}

export function PartnerCard({ partner }: PartnerCardProps) {
  return (
    <div className="group bg-surface-container-lowest rounded-xl partner-card-shadow border border-surface-variant overflow-hidden flex flex-col transition-all duration-300">
      <div className="p-6 flex-grow">
        <div className="flex justify-between items-start mb-6">
          <div className="w-20 h-20 bg-surface-container rounded-xl overflow-hidden flex items-center justify-center p-2 border border-outline-variant">
            <img 
              className="w-full h-full object-contain" 
              src={partner.logo} 
              alt={partner.name} 
            />
          </div>
          <div className="flex flex-col items-end">
            <div className="flex items-center gap-1 text-secondary font-bold">
              <span className="material-symbols-outlined" style={{ fontVariationSettings: "'FILL' 1" }}>star</span>
              <span className="font-headline-md text-headline-md">{partner.rating}</span>
            </div>
            <span className="font-label-sm text-label-sm text-outline">{partner.reviews} Reviews</span>
          </div>
        </div>
        
        <h3 className="font-headline-md text-headline-md mb-2">{partner.name}</h3>
        
        <div className="flex gap-2 mb-4">
          {partner.tags.map(tag => (
            <span key={tag} className="px-2 py-0.5 bg-tertiary/10 text-tertiary font-label-sm rounded border border-tertiary/20">
              {tag}
            </span>
          ))}
        </div>
        
        <div className="space-y-2 mb-6">
          <p className="font-label-sm text-label-sm text-outline uppercase tracking-wider">Top Routes</p>
          <ul className="space-y-1">
            {partner.routes.map(route => (
              <li key={route} className="flex items-center gap-2 font-body-md text-body-md">
                <span className="material-symbols-outlined text-primary scale-75">route</span>
                {route}
              </li>
            ))}
          </ul>
        </div>
      </div>
      
      <div className="px-6 pb-6 pt-0">
        <Link to={`/partners/${partner.id}`} className="block w-full py-3 border border-primary text-primary font-label-md rounded-lg hover:bg-primary hover:text-on-primary transition-all duration-300 text-center">
          View Details
        </Link>
      </div>
    </div>
  );
}
