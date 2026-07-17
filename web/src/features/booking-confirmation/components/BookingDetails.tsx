export function BookingDetails() {
  return (
    <div className="p-8 space-y-8">
      {/* ID and Summary Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div>
          <p className="text-label-sm text-outline font-label-sm uppercase tracking-wider mb-1">Mã đặt vé</p>
          <p className="text-headline-md font-headline-md text-primary">IV-2948512</p>
        </div>
        <div className="md:text-right">
          <p className="text-label-sm text-outline font-label-sm uppercase tracking-wider mb-1">Trạng thái</p>
          <span className="inline-flex items-center gap-1.5 py-1 px-3 rounded-full bg-tertiary-container text-on-tertiary-container text-label-md font-label-md">
            <span className="w-2 h-2 rounded-full bg-on-tertiary-container"></span>
            Đã thanh toán
          </span>
        </div>
      </div>

      {/* Journey Card */}
      <div className="bg-surface-container-low rounded-lg p-6 border border-outline-variant">
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
          {/* Route Info */}
          <div className="flex-1 flex items-center gap-6 w-full md:w-auto">
            <div className="text-center min-w-[80px]">
              <p className="font-headline-md text-headline-md text-on-surface">Hà Nội</p>
              <p className="text-body-sm text-on-surface-variant">25/10/2024</p>
            </div>
            <div className="flex-grow flex items-center gap-2">
              <div className="w-2 h-2 rounded-full bg-primary"></div>
              <div className="flex-grow h-px dotted-divider"></div>
              <span className="material-symbols-outlined text-primary">directions_bus</span>
              <div className="flex-grow h-px dotted-divider"></div>
              <div className="w-2 h-2 rounded-full border border-primary"></div>
            </div>
            <div className="text-center min-w-[80px]">
              <p className="font-headline-md text-headline-md text-on-surface">Sapa</p>
              <p className="text-body-sm text-on-surface-variant">25/10/2024</p>
            </div>
          </div>
        </div>

        <div className="mt-6 pt-6 border-t border-outline-variant grid grid-cols-2 md:grid-cols-4 gap-4">
          <div>
            <p className="text-label-sm text-outline font-label-sm">Số ghế</p>
            <p className="font-label-md text-on-surface">12A, 12B</p>
          </div>
          <div>
            <p className="text-label-sm text-outline font-label-sm">Hạng vé</p>
            <p className="font-label-md text-on-surface">Giường nằm Pro</p>
          </div>
          <div>
            <p className="text-label-sm text-outline font-label-sm">Khởi hành</p>
            <p className="font-label-md text-on-surface">08:30 AM</p>
          </div>
          <div className="md:text-right">
            <p className="text-label-sm text-outline font-label-sm">Tổng tiền</p>
            <p className="font-headline-md text-headline-md text-secondary-container">$124.50</p>
          </div>
        </div>
      </div>
    </div>
  );
}
