export function WhyChooseUs() {
  return (
    <section className="py-24 bg-surface-container-lowest">
      <div className="px-gutter max-w-container-max mx-auto">
        <div className="text-center max-w-2xl mx-auto mb-16 space-y-4">
          <h2 className="font-headline-lg text-headline-lg">Why Choose Us</h2>
          <p className="font-body-md text-body-md text-on-surface-variant">
            We prioritize what matters most to travelers: security, time, and support.
          </p>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Safety */}
          <div className="bg-surface p-8 rounded-2xl shadow-sm border border-outline-variant hover:shadow-md transition-all group">
            <div className="w-16 h-16 bg-primary-container/10 rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary-container transition-colors">
              <span className="material-symbols-outlined text-primary text-3xl group-hover:text-on-primary">shield_person</span>
            </div>
            <h3 className="font-headline-md text-headline-md mb-3">Uncompromising Safety</h3>
            <p className="font-body-sm text-body-sm text-on-surface-variant leading-relaxed">
              Our fleet undergoes rigorous bi-weekly inspections and all drivers are certified with advanced safety training modules.
            </p>
          </div>
          {/* Punctuality */}
          <div className="bg-surface p-8 rounded-2xl shadow-sm border border-outline-variant hover:shadow-md transition-all group">
            <div className="w-16 h-16 bg-primary-container/10 rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary-container transition-colors">
              <span className="material-symbols-outlined text-primary text-3xl group-hover:text-on-primary">schedule</span>
            </div>
            <h3 className="font-headline-md text-headline-md mb-3">Guaranteed Punctuality</h3>
            <p className="font-body-sm text-body-sm text-on-surface-variant leading-relaxed">
              With AI-driven route optimization and real-time monitoring, we boast a 99% on-time performance record across the country.
            </p>
          </div>
          {/* 24/7 Support */}
          <div className="bg-surface p-8 rounded-2xl shadow-sm border border-outline-variant hover:shadow-md transition-all group">
            <div className="w-16 h-16 bg-primary-container/10 rounded-xl flex items-center justify-center mb-6 group-hover:bg-primary-container transition-colors">
              <span className="material-symbols-outlined text-primary text-3xl group-hover:text-on-primary">support_agent</span>
            </div>
            <h3 className="font-headline-md text-headline-md mb-3">24/7 Human Support</h3>
            <p className="font-body-sm text-body-sm text-on-surface-variant leading-relaxed">
              No bots. Access real assistance anytime, anywhere through our dedicated hotline or live chat for booking changes or travel help.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
