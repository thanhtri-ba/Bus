import { TripSummary } from '../components/TripSummary';
import { ReviewForm } from '../components/ReviewForm';

export function TripReviewPage() {
  return (
    <main className="flex-grow w-full max-w-container-max mx-auto px-margin-mobile md:px-gutter py-8 md:py-12">
      <div className="max-w-4xl mx-auto">
        {/* Header Section */}
        <div className="mb-8 text-center md:text-left">
          <h1 className="font-headline-lg text-headline-lg mb-2">Đánh giá chuyến đi của bạn</h1>
          <p className="text-on-surface-variant font-body-md">
            Cảm ơn bạn đã đồng hành cùng Intercity Velocity. Phản hồi của bạn giúp chúng tôi nâng cao chất lượng dịch vụ.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-12 gap-8">
          <TripSummary />
          <ReviewForm />
        </div>
      </div>
    </main>
  );
}
