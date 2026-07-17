import { SuccessHeader } from '../components/SuccessHeader';
import { BookingDetails } from '../components/BookingDetails';
import { ActionButtons } from '../components/ActionButtons';
import { PromotionSection } from '../components/PromotionSection';

export function BookingConfirmationPage() {
  return (
    <main className="flex-grow flex items-center justify-center py-12 px-4">
      <div className="w-full max-w-3xl">
        
        {/* Success Hero Card */}
        <div className="bg-surface-container-lowest rounded-xl shadow-level-2 overflow-hidden border border-outline-variant">
          <SuccessHeader />
          <BookingDetails />
          <ActionButtons />
          
          {/* Footer Tip */}
          <div className="bg-surface-container p-6 text-center">
            <p className="text-body-sm text-on-surface-variant flex items-center justify-center gap-2">
              <span className="material-symbols-outlined text-primary text-lg">info</span>
              Vui lòng có mặt tại bến trước giờ khởi hành ít nhất 30 phút.
            </p>
          </div>
        </div>

        <PromotionSection />

      </div>
    </main>
  );
}
