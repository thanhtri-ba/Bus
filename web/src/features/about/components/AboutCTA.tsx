export function AboutCTA() {
  return (
    <section className="py-24 px-gutter">
      <div className="max-w-container-max mx-auto bg-primary rounded-3xl p-12 md:p-20 text-center relative overflow-hidden">
        <div className="absolute top-0 right-0 w-64 h-64 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2 blur-3xl"></div>
        <div className="absolute bottom-0 left-0 w-48 h-48 bg-secondary-container/20 rounded-full translate-y-1/2 -translate-x-1/2 blur-2xl"></div>
        <div className="relative z-10 space-y-8">
          <h2 className="font-headline-xl text-headline-xl text-on-primary max-w-3xl mx-auto">
            Ready to experience the future of intercity travel?
          </h2>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <button className="bg-secondary-container text-on-secondary-container font-headline-md text-headline-md px-10 py-4 rounded-xl hover:scale-105 transition-transform active:opacity-80">
              Book Your Journey
            </button>
            <button className="border border-on-primary text-on-primary font-headline-md text-headline-md px-10 py-4 rounded-xl hover:bg-on-primary hover:text-primary transition-all">
              View All Routes
            </button>
          </div>
        </div>
      </div>
    </section>
  );
}
