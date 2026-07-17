import { SearchSummaryBar } from '../components/SearchSummaryBar';
import { SearchFilter } from '../components/SearchFilter';
import { TripList } from '../components/TripList';
import { MobileBottomNav } from '../../../shared/components/MobileBottomNav';

export function TripSearchPage() {
  return (
    <>
      <SearchSummaryBar />
      <main className="max-w-container-max mx-auto px-gutter py-8">
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
          <SearchFilter />
          <TripList />
        </div>
      </main>
      <MobileBottomNav />
    </>
  );
}
