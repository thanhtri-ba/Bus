export function PopularRoutesTable() {
  return (
    <div className="space-y-6">
      <h2 className="font-headline-md text-headline-md flex items-center gap-3">
        <span className="w-2 h-8 bg-primary rounded-full"></span>
        Popular Routes
      </h2>
      <div className="bg-surface border border-outline-variant rounded-xl overflow-hidden">
        <table className="w-full text-left">
          <thead className="bg-surface-container-low">
            <tr>
              <th className="px-6 py-4 font-label-md text-label-md text-on-surface-variant">Route</th>
              <th className="px-6 py-4 font-label-md text-label-md text-on-surface-variant">Duration</th>
              <th className="px-6 py-4 font-label-md text-label-md text-on-surface-variant">Frequency</th>
              <th className="px-6 py-4 font-label-md text-label-md text-on-surface-variant">Fare</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-outline-variant">
            <tr className="hover:bg-surface-container transition-colors cursor-pointer">
              <td className="px-6 py-5">
                <div className="flex items-center gap-2 font-label-md text-label-md">
                  <span>New York</span>
                  <span className="material-symbols-outlined text-primary text-sm">arrow_forward</span>
                  <span>Boston</span>
                </div>
              </td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">4h 30m</td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">Every 30 mins</td>
              <td className="px-6 py-5 font-bold text-primary">$32.00</td>
            </tr>
            <tr className="hover:bg-surface-container transition-colors cursor-pointer">
              <td className="px-6 py-5">
                <div className="flex items-center gap-2 font-label-md text-label-md">
                  <span>Boston</span>
                  <span className="material-symbols-outlined text-primary text-sm">arrow_forward</span>
                  <span>Washington DC</span>
                </div>
              </td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">7h 15m</td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">Daily (5 trips)</td>
              <td className="px-6 py-5 font-bold text-primary">$45.00</td>
            </tr>
            <tr className="hover:bg-surface-container transition-colors cursor-pointer">
              <td className="px-6 py-5">
                <div className="flex items-center gap-2 font-label-md text-label-md">
                  <span>Philadelphia</span>
                  <span className="material-symbols-outlined text-primary text-sm">arrow_forward</span>
                  <span>New York</span>
                </div>
              </td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">2h 10m</td>
              <td className="px-6 py-5 text-body-sm text-on-surface-variant">Hourly</td>
              <td className="px-6 py-5 font-bold text-primary">$25.00</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  );
}
