import { PartnersHeader } from '../components/PartnersHeader';
import { PartnersSearchFilter } from '../components/PartnersSearchFilter';
import { PartnersGrid } from '../components/PartnersGrid';
import { Pagination } from '../../../shared/components/Pagination';

export function PartnersPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-12">
      <PartnersHeader />
      <PartnersSearchFilter />
      <PartnersGrid />
      <Pagination />
    </main>
  );
}
