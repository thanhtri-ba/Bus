import { RewardSummary } from '../components/RewardSummary';
import { VoucherList } from '../components/VoucherList';
import { PointsHistory } from '../components/PointsHistory';

export function OffersPage() {
  return (
    <main className="max-w-container-max mx-auto px-gutter py-8 md:py-12">
      <RewardSummary />
      <VoucherList />
      <PointsHistory />
    </main>
  );
}
