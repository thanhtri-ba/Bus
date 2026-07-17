import { useState } from 'react';

export function SuccessHeader() {
  const [trigger, setTrigger] = useState(0);

  // Trigger animation on hover
  const handleMouseEnter = () => {
    setTrigger((prev) => prev + 1);
  };

  return (
    <div className="bg-tertiary-container/10 p-8 text-center flex flex-col items-center">
      <div 
        key={trigger} // Re-renders the div to restart animation
        className="success-checkmark w-20 h-20 bg-tertiary-container rounded-full flex items-center justify-center mb-4"
        onMouseEnter={handleMouseEnter}
      >
        <span className="material-symbols-outlined text-on-tertiary-container text-5xl" style={{ fontVariationSettings: "'FILL' 1" }}>
          check_circle
        </span>
      </div>
      <h1 className="font-headline-lg text-headline-lg text-on-surface mb-2">Đặt vé thành công!</h1>
      <p className="text-on-surface-variant max-w-md mx-auto">
        Cảm ơn bạn đã tin tưởng Intercity Velocity. Thông tin chi tiết vé đã được gửi đến email của bạn.
      </p>
    </div>
  );
}
