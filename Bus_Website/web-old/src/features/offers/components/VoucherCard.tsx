import { useState } from 'react';

export interface VoucherProps {
  discount: string;
  unit: string;
  bgColorClass: string;
  textColorClass: string;
  title: string;
  expiry: string;
  code: string;
}

export function VoucherCard({ discount, unit, bgColorClass, textColorClass, title, expiry, code }: VoucherProps) {
  const [copied, setCopied] = useState(false);

  const handleCopy = () => {
    navigator.clipboard.writeText(code).then(() => {
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    });
  };

  return (
    <div className="flex bg-white rounded-xl overflow-hidden card-elevation border border-outline-variant">
      <div className={`w-24 ${bgColorClass} flex flex-col items-center justify-center p-4 ${textColorClass} relative`}>
        <span className="font-headline-md text-headline-md">{discount}</span>
        <span className="font-label-sm text-center">{unit}</span>
        <div className="absolute top-1/2 -left-2 w-4 h-4 bg-surface rounded-full -translate-y-1/2"></div>
        <div className="absolute top-1/2 -right-2 w-4 h-4 bg-surface rounded-full -translate-y-1/2"></div>
      </div>
      <div className="flex-1 p-4 flex flex-col justify-between">
        <div>
          <h4 className="font-label-md text-on-surface line-clamp-1">{title}</h4>
          <p className="text-xs text-on-surface-variant">Hết hạn: {expiry}</p>
        </div>
        <div className="mt-4 flex gap-2">
          <button 
            className={`flex-1 px-2 py-2 border rounded-lg font-label-sm transition-colors flex items-center justify-center gap-1 ${
              copied 
                ? 'bg-tertiary-container text-on-tertiary-container border-tertiary-container' 
                : 'border-primary text-primary hover:bg-primary-fixed'
            }`} 
            onClick={handleCopy}
          >
            <span className="material-symbols-outlined text-sm">
              {copied ? 'check' : 'content_copy'}
            </span>
            {copied ? 'Đã chép' : code}
          </button>
          <button className="flex-1 px-2 py-2 bg-secondary text-on-secondary rounded-lg font-label-sm hover:opacity-90 transition-colors">
            Dùng ngay
          </button>
        </div>
      </div>
    </div>
  );
}
