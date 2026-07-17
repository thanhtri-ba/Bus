export function SettingsDrawer({ isOpen, onClose }: { isOpen: boolean; onClose: () => void }) {
  return (
    <div 
      className={`fixed inset-0 bg-black/50 z-[100] transition-opacity duration-300 ${isOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'}`} 
      id="settings-overlay"
      onClick={onClose}
    >
      <div 
        className={`absolute right-0 top-0 h-full w-full max-w-md bg-surface shadow-2xl transition-transform duration-300 flex flex-col ${isOpen ? 'translate-x-0' : 'translate-x-full'}`} 
        id="settings-panel"
        onClick={e => e.stopPropagation()} // Prevent clicks inside from closing the drawer
      >
        <div className="p-6 border-b border-outline-variant flex justify-between items-center bg-surface-container-low">
          <h2 className="font-headline-md text-headline-md text-on-surface">Cài đặt thông báo</h2>
          <button className="w-10 h-10 rounded-full hover:bg-surface-container flex items-center justify-center" onClick={onClose}>
            <span className="material-symbols-outlined">close</span>
          </button>
        </div>
        
        <div className="flex-1 overflow-y-auto p-6 space-y-8 custom-scrollbar">
          {/* Method section */}
          <div>
            <h3 className="font-label-md text-label-md text-primary mb-4 uppercase tracking-wider">Phương thức nhận</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-body-md text-body-md font-semibold text-on-surface">Email</p>
                  <p className="font-body-sm text-body-sm text-on-surface-variant">Nhận cập nhật qua hòm thư điện tử</p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input defaultChecked className="sr-only peer" type="checkbox" />
                  <div className="w-11 h-6 bg-outline-variant peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-body-md text-body-md font-semibold text-on-surface">Thông báo đẩy (Push)</p>
                  <p className="font-body-sm text-body-sm text-on-surface-variant">Nhận thông báo trực tiếp trên thiết bị</p>
                </div>
                <label className="relative inline-flex items-center cursor-pointer">
                  <input defaultChecked className="sr-only peer" type="checkbox" />
                  <div className="w-11 h-6 bg-outline-variant peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
            </div>
          </div>
          
          {/* Topics section */}
          <div>
            <h3 className="font-label-md text-label-md text-primary mb-4 uppercase tracking-wider">Chủ đề quan tâm</h3>
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <p className="font-body-md text-body-md text-on-surface">Trạng thái chuyến đi</p>
                <input defaultChecked className="rounded border-outline text-primary focus:ring-primary h-5 w-5" type="checkbox" />
              </div>
              <div className="flex items-center justify-between">
                <p className="font-body-md text-body-md text-on-surface">Khuyến mãi &amp; Ưu đãi</p>
                <input defaultChecked className="rounded border-outline text-primary focus:ring-primary h-5 w-5" type="checkbox" />
              </div>
              <div className="flex items-center justify-between">
                <p className="font-body-md text-body-md text-on-surface">Nhắc nhở thanh toán</p>
                <input defaultChecked className="rounded border-outline text-primary focus:ring-primary h-5 w-5" type="checkbox" />
              </div>
              <div className="flex items-center justify-between">
                <p className="font-body-md text-body-md text-on-surface">Tin tức hệ thống</p>
                <input className="rounded border-outline text-primary focus:ring-primary h-5 w-5" type="checkbox" />
              </div>
            </div>
          </div>
        </div>
        
        {/* Footer actions */}
        <div className="pt-6 border-t border-outline-variant p-6">
          <button className="w-full bg-primary text-on-primary py-3 rounded-xl font-headline-md text-headline-md shadow-md hover:opacity-90 transition-all" onClick={onClose}>
            Lưu thay đổi
          </button>
          <button className="w-full mt-2 py-3 text-on-surface-variant font-label-md text-label-md hover:underline transition-all" onClick={onClose}>
            Hủy bỏ
          </button>
        </div>
      </div>
    </div>
  );
}
