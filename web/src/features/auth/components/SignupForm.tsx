export function SignupForm({ isVisible }: { isVisible: boolean }) {
  return (
    <form 
      className={`space-y-6 form-transition ${isVisible ? 'opacity-100' : 'hidden opacity-0 translate-x-4'}`}
      id="signup-form"
    >
      <div className="grid grid-cols-2 gap-4">
        <div className="col-span-1">
          <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="signup-fname">Họ</label>
          <input 
            className="w-full px-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
            id="signup-fname" 
            placeholder="Nguyễn" 
            type="text" 
          />
        </div>
        <div className="col-span-1">
          <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="signup-lname">Tên</label>
          <input 
            className="w-full px-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
            id="signup-lname" 
            placeholder="Anh" 
            type="text" 
          />
        </div>
      </div>
      <div>
        <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="signup-email">Email</label>
        <input 
          className="w-full px-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
          id="signup-email" 
          placeholder="example@gmail.com" 
          type="email" 
        />
      </div>
      <div>
        <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="signup-phone">Số điện thoại</label>
        <input 
          className="w-full px-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
          id="signup-phone" 
          placeholder="0901 234 567" 
          type="tel" 
        />
      </div>
      <div>
        <label className="block font-label-md text-label-md text-on-surface mb-2" htmlFor="signup-password">Mật khẩu</label>
        <input 
          className="w-full px-4 py-3 bg-white border border-outline-variant rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all font-body-md text-body-md" 
          id="signup-password" 
          placeholder="Tối thiểu 8 ký tự" 
          type="password" 
        />
      </div>
      <button 
        className="w-full bg-primary-container hover:bg-primary text-white font-label-md text-label-md py-4 rounded-lg shadow-md transition-all active:scale-[0.98] focus:ring-4 focus:ring-primary-fixed" 
        type="submit"
      >
        Tạo tài khoản
      </button>
    </form>
  );
}
