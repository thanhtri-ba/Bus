export function AboutHero() {
  return (
    <section className="relative h-[614px] min-h-[400px] flex items-center overflow-hidden">
      <div className="absolute inset-0 z-0">
        <div 
          className="w-full h-full bg-cover bg-center" 
          style={{ backgroundImage: "url('https://lh3.googleusercontent.com/aida-public/AB6AXuBJravOgwXCWfQBMZUMXEPim1IWuJfL9rPfkKtdjv8fWCd6Vr-8GGNrDb6qJ916RUKpFuqkytGFzwC6uE1sSYxzmI0as3mSKoBGKPhzC8tTS_dooVpEp5NGfU_Yst2MBOc53CriGeWR5o-UTtDqygX5eHQIKfjdHy6HpTq3ErtT8gjUfUH8A1-L4-bBxiZmL-JUwFN36zCa-2UipJQP3EOSzflyAwdNd_lXg3YwJK9GiHTROyULEaNWDQ')" }}
        ></div>
        <div className="absolute inset-0 bg-gradient-to-r from-on-surface/80 to-transparent"></div>
      </div>
      <div className="relative z-10 w-full px-gutter max-w-container-max mx-auto text-on-primary">
        <div className="max-w-2xl">
          <span className="inline-block px-3 py-1 bg-secondary-container text-on-secondary-container font-label-sm text-label-sm rounded-lg mb-6 tracking-wider uppercase">Our Mission</span>
          <h1 className="font-headline-xl text-headline-xl mb-4 leading-tight">Reliable travel across Vietnam.</h1>
          <p className="font-body-lg text-body-lg text-surface-variant opacity-90 max-w-lg">
            We bridge distances with safety and precision, connecting people across the vibrant landscapes of Vietnam with world-class intercity logistics.
          </p>
        </div>
      </div>
    </section>
  );
}
