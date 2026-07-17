export function NewsletterForm() {
  return (
    <section className="bg-surface-container rounded-2xl p-8 md:p-12 text-center space-y-6">
      <div className="max-w-2xl mx-auto space-y-4">
        <h2 className="font-headline-lg text-headline-lg">Đừng bỏ lỡ bất kỳ ưu đãi nào!</h2>
        <p className="text-on-surface-variant font-body-md">
          Đăng ký nhận tin để cập nhật những chương trình khuyến mãi sớm nhất và các mẹo du lịch hữu ích hàng tuần.
        </p>
        <form className="flex flex-col md:flex-row gap-3 mt-8">
          <input 
            className="flex-grow px-6 py-3 rounded-lg border border-outline focus:ring-2 focus:ring-primary focus:border-transparent outline-none bg-white" 
            placeholder="Địa chỉ email của bạn" 
            type="email" 
            required 
          />
          <button 
            className="bg-primary text-on-primary font-bold px-8 py-3 rounded-lg hover:bg-primary-container transition-all" 
            type="submit"
          >
            Đăng ký ngay
          </button>
        </form>
        <p className="text-[12px] text-outline">
          Chúng tôi cam kết bảo mật thông tin của bạn. Xem <a className="underline hover:text-primary" href="#">Chính sách bảo mật</a>.
        </p>
      </div>
    </section>
  );
}
