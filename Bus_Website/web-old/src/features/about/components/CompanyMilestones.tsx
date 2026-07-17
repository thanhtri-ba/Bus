export function CompanyMilestones() {
  return (
    <section className="py-12 bg-surface-container relative z-20 -mt-12 mx-gutter max-w-container-max md:mx-auto rounded-xl shadow-md grid grid-cols-2 md:grid-cols-4 gap-8 px-12 text-center">
      <div className="space-y-1">
        <p className="font-headline-lg text-headline-lg text-primary">500+</p>
        <p className="font-label-md text-label-md text-on-surface-variant">Daily Routes</p>
      </div>
      <div className="space-y-1">
        <p className="font-headline-lg text-headline-lg text-primary">1M+</p>
        <p className="font-label-md text-label-md text-on-surface-variant">Yearly Passengers</p>
      </div>
      <div className="space-y-1">
        <p className="font-headline-lg text-headline-lg text-primary">64</p>
        <p className="font-label-md text-label-md text-on-surface-variant">Cities Connected</p>
      </div>
      <div className="space-y-1">
        <p className="font-headline-lg text-headline-lg text-primary">99%</p>
        <p className="font-label-md text-label-md text-on-surface-variant">On-time Arrival</p>
      </div>
    </section>
  );
}
