import { useState } from 'react';

export function HelpHero() {
  const [isFocused, setIsFocused] = useState(false);

  return (
    <section className="relative py-20 overflow-hidden bg-primary-container">
      <div className="relative z-10 max-w-container-max mx-auto px-gutter text-center text-on-primary-container">
        <h1 className="font-headline-xl text-headline-xl mb-6">Bạn cần chúng tôi giúp gì?</h1>
        <div className={`max-w-2xl mx-auto relative group transition-transform duration-300 ${isFocused ? 'scale-[1.02]' : ''}`}>
          <div className="absolute inset-y-0 left-5 flex items-center pointer-events-none text-outline">
            <span className="material-symbols-outlined">search</span>
          </div>
          <input 
            className="w-full pl-14 pr-6 py-5 rounded-xl bg-surface text-on-surface border-none shadow-xl focus:ring-4 focus:ring-secondary-container/20 text-body-lg font-body-lg transition-all" 
            placeholder="Tìm kiếm câu hỏi, chính sách hoặc từ khóa..." 
            type="text"
            onFocus={() => setIsFocused(true)}
            onBlur={() => setIsFocused(false)}
          />
        </div>
        <div className="mt-6 flex flex-wrap justify-center gap-4">
          <span className="text-on-primary-container/80 font-label-md text-label-md py-1">Gợi ý:</span>
          <button className="bg-white/10 hover:bg-white/20 px-3 py-1 rounded-full transition-colors font-label-sm text-label-sm">Hủy vé</button>
          <button className="bg-white/10 hover:bg-white/20 px-3 py-1 rounded-full transition-colors font-label-sm text-label-sm">Đổi lịch trình</button>
          <button className="bg-white/10 hover:bg-white/20 px-3 py-1 rounded-full transition-colors font-label-sm text-label-sm">Quy định hành lý</button>
        </div>
      </div>
    </section>
  );
}
