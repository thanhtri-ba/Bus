import { useState } from 'react';

interface StarRatingProps {
  value: number;
  onChange: (value: number) => void;
}

export function StarRating({ value, onChange }: StarRatingProps) {
  const [hoverValue, setHoverValue] = useState(0);

  return (
    <div className="flex gap-1" onMouseLeave={() => setHoverValue(0)}>
      {[1, 2, 3, 4, 5].map((star) => {
        const isActive = star <= (hoverValue || value);
        return (
          <span
            key={star}
            className={`material-symbols-outlined cursor-pointer text-3xl transition-colors ${
              isActive ? 'text-secondary-container' : 'text-outline-variant'
            }`}
            style={{ fontVariationSettings: isActive ? "'FILL' 1" : "'FILL' 0" }}
            onClick={() => onChange(star)}
            onMouseEnter={() => setHoverValue(star)}
          >
            star
          </span>
        );
      })}
    </div>
  );
}
