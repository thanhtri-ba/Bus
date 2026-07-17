import { useEffect, useState } from 'react';

export function AuthVisual() {
  const [transform, setTransform] = useState('scale(1.05) translate(0px, 0px)');

  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (window.innerWidth >= 1024) {
        const moveX = (e.clientX - window.innerWidth / 2) * 0.01;
        const moveY = (e.clientY - window.innerHeight / 2) * 0.01;
        setTransform(`scale(1.05) translate(${moveX}px, ${moveY}px)`);
      }
    };
    
    document.addEventListener('mousemove', handleMouseMove);
    return () => document.removeEventListener('mousemove', handleMouseMove);
  }, []);

  return (
    <section className="hidden lg:flex lg:w-1/2 relative overflow-hidden">
      <div className="absolute inset-0 z-0">
        <div 
          className="w-full h-full bg-cover bg-center transition-transform duration-75"
          style={{ 
            backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuC-gt5QLaG0_D2uRvp2ItmYKzw-49OfAxWLGTxHHdo72Qi1rYKJGAQ473Mxhf2UqYC54TWrO2FV1p0oNzw4pgSvVeUvc8Yhpw-Ir18qoZC4JDKFeHGkgvgzHVv7j8nGsTinBhidOCq_s76w56kYLqczkow5Kut5x0zccxOFo-NVmhUtmpBzun1REzgQ__p8kNneoR604aN8ZMitmOQeSyawIY8EzcbIHHeGgnmSggIVxIFfdd-8JLRpEg')",
            transform
          }}
        ></div>
        <div className="absolute inset-0 bg-gradient-to-r from-transparent to-surface/30"></div>
      </div>
      <div className="relative z-10 p-16 flex flex-col justify-between w-full">
        <div>
          <h1 className="font-headline-xl text-headline-xl text-white drop-shadow-lg max-w-md">
            Kết Nối Hành Trình Của Bạn.
          </h1>
          <p className="font-body-lg text-body-lg text-white/90 mt-4 drop-shadow-md max-w-sm">
            Trải nghiệm dịch vụ vận tải liên tỉnh hiện đại, an toàn và đúng giờ cùng Intercity Velocity.
          </p>
        </div>
        <div className="bg-glass p-6 rounded-xl border border-white/20 self-start">
          <div className="flex items-center space-x-4">
            <div className="w-12 h-12 bg-secondary-container rounded-full flex items-center justify-center text-white">
              <span className="material-symbols-outlined">directions_bus</span>
            </div>
            <div>
              <p className="font-label-md text-label-md text-on-surface">Chuyến đi sắp tới</p>
              <p className="font-body-sm text-body-sm text-on-surface-variant">Hà Nội — Đà Nẵng | 20:00 Tối nay</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
