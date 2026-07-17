import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { StarRating } from './StarRating';

export function ReviewForm() {
  const navigate = useNavigate();
  const [ratings, setRatings] = useState({
    quality: 0,
    driver: 0,
    punctual: 0,
    clean: 0,
  });
  const [comments, setComments] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState<'idle' | 'success'>('idle');

  const handleRatingChange = (category: keyof typeof ratings, value: number) => {
    setRatings((prev) => ({ ...prev, [category]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    // Simulate API call
    setTimeout(() => {
      setIsSubmitting(false);
      setSubmitStatus('success');

      setTimeout(() => {
        setSubmitStatus('idle');
        setRatings({ quality: 0, driver: 0, punctual: 0, clean: 0 });
        setComments('');
        // Navigate back to bookings after reviewing
        navigate('/my-bookings');
      }, 1500);
    }, 1000);
  };

  return (
    <div className="md:col-span-8">
      <form 
        className="bg-surface-container-lowest p-8 rounded-xl border border-outline-variant shadow-level-2 space-y-8" 
        id="review-form"
        onSubmit={handleSubmit}
      >
        {/* Rating Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-8">
          {/* Quality */}
          <div className="space-y-2">
            <label className="font-label-md text-label-md text-on-surface-variant flex items-center gap-2">
              <span className="material-symbols-outlined text-primary scale-90">airline_seat_recline_extra</span>
              Chất lượng xe
            </label>
            <StarRating value={ratings.quality} onChange={(v) => handleRatingChange('quality', v)} />
          </div>

          {/* Driver */}
          <div className="space-y-2">
            <label className="font-label-md text-label-md text-on-surface-variant flex items-center gap-2">
              <span className="material-symbols-outlined text-primary scale-90">badge</span>
              Thái độ tài xế
            </label>
            <StarRating value={ratings.driver} onChange={(v) => handleRatingChange('driver', v)} />
          </div>

          {/* Punctuality */}
          <div className="space-y-2">
            <label className="font-label-md text-label-md text-on-surface-variant flex items-center gap-2">
              <span className="material-symbols-outlined text-primary scale-90">schedule</span>
              Đúng giờ
            </label>
            <StarRating value={ratings.punctual} onChange={(v) => handleRatingChange('punctual', v)} />
          </div>

          {/* Cleanliness */}
          <div className="space-y-2">
            <label className="font-label-md text-label-md text-on-surface-variant flex items-center gap-2">
              <span className="material-symbols-outlined text-primary scale-90">cleaning_services</span>
              Sạch sẽ
            </label>
            <StarRating value={ratings.clean} onChange={(v) => handleRatingChange('clean', v)} />
          </div>
        </div>

        {/* Textarea */}
        <div className="space-y-3">
          <label className="font-label-md text-label-md text-on-surface-variant" htmlFor="comments">Nhận xét chi tiết</label>
          <textarea 
            className="w-full bg-surface-container-lowest border border-outline-variant rounded-xl p-4 focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all placeholder:text-outline-variant font-body-md" 
            id="comments" 
            placeholder="Chia sẻ thêm về trải nghiệm của bạn (ví dụ: tiện nghi, trạm dừng, lái xe an toàn...)" 
            rows={5}
            value={comments}
            onChange={(e) => setComments(e.target.value)}
          ></textarea>
        </div>

        {/* Submit Button */}
        <div className="pt-4">
          <button 
            className={`w-full text-white py-4 rounded-xl font-headline-md text-headline-md transition-all shadow-lg flex items-center justify-center gap-2 ${
              submitStatus === 'success' ? 'bg-tertiary-container' : 'bg-secondary-container hover:bg-secondary active:scale-[0.98]'
            }`} 
            type="submit"
            disabled={isSubmitting || submitStatus === 'success'}
          >
            {isSubmitting ? (
              <>
                <span className="material-symbols-outlined animate-spin">sync</span> Đang gửi...
              </>
            ) : submitStatus === 'success' ? (
              <>
                <span className="material-symbols-outlined">check_circle</span> Đã gửi thành công!
              </>
            ) : (
              <>
                Gửi đánh giá
                <span className="material-symbols-outlined">send</span>
              </>
            )}
          </button>
          <p className="text-center text-body-sm font-body-sm text-on-surface-variant mt-4">
            Phản hồi của bạn sẽ được hiển thị công khai để giúp đỡ những hành khách khác.
          </p>
        </div>
      </form>
    </div>
  );
}
