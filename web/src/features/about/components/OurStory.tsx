export function OurStory() {
  return (
    <section className="py-24 px-gutter max-w-container-max mx-auto">
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div className="space-y-8">
          <div className="space-y-4">
            <h2 className="font-headline-lg text-headline-lg text-on-surface">Our Story</h2>
            <p className="font-body-md text-body-md text-on-surface-variant leading-relaxed">
              Founded in 2018, Intercity Velocity emerged from a simple observation: Vietnam's rapid growth deserved a transit network that matched its ambition. What started with three routes from Ho Chi Minh City has evolved into a nationwide infrastructure of reliability.
            </p>
            <p className="font-body-md text-body-md text-on-surface-variant leading-relaxed">
              We don't just book tickets; we manage journeys. By integrating advanced tracking technology with a customer-first service culture, we've redefined what passengers expect from intercity bus travel in Southeast Asia. Our commitment to transparency and punctuality remains our guiding star.
            </p>
          </div>
          <div className="p-6 bg-surface-container-low border-l-4 border-primary rounded-r-xl">
            <p className="font-body-md italic text-on-surface-variant">
              "Our goal was never just to be the largest, but to be the most trusted. Every kilometer we drive is a promise kept to a family, a business, or a traveler."
            </p>
            <p className="mt-4 font-label-md text-label-md text-on-surface">— Minh Nguyen, CEO &amp; Founder</p>
          </div>
        </div>
        <div className="relative group">
          <div className="absolute -inset-4 bg-primary-container/10 rounded-xl blur-2xl group-hover:bg-primary-container/20 transition-all"></div>
          <div className="relative h-[500px] w-full rounded-2xl overflow-hidden shadow-xl">
            <img 
              className="w-full h-full object-cover" 
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuA9lLGWn14Bc2ArwWjpeArdBuXFZsDmjVQNVcwIhELWlzYpjV4wr4tzLSCT4wSYjJjXPGJHJq3wOG0uZ3AoykVnxNi82saxBDiux_0w9FzuHj13AIo5_xg2-QWhtrHeDSGHjwukL-aBRWR05Tn73MZGEDjeBhPFP4sAecforrpcQXlGvw5ajw8GIzb88ACdKzPlex_VMVDE7oYI44u95b5y8R6CUTQzht3231KvoZZHTdsT0rCUKPfHIQ" 
              alt="Our Team" 
            />
          </div>
        </div>
      </div>
    </section>
  );
}
