import { useState } from 'react';

export function TopFAQs() {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  const faqs = [
    {
      q: 'Làm thế nào để thay đổi lịch trình vé đã đặt?',
      a: 'Bạn có thể thay đổi lịch trình thông qua ứng dụng Intercity Velocity hoặc trang web trong mục "Quản lý vé". Lưu ý rằng việc thay đổi phải thực hiện ít nhất 24 giờ trước giờ khởi hành và có thể áp dụng phí chuyển đổi tùy theo loại vé.'
    },
    {
      q: 'Hệ thống chấp nhận những phương thức thanh toán nào?',
      a: 'Chúng tôi hỗ trợ đa dạng phương thức bao gồm: Thẻ tín dụng/ghi nợ (Visa, Mastercard), Ví điện tử (Momo, ZaloPay), Chuyển khoản ngân hàng qua mã QR, và thanh toán tại các cửa hàng tiện lợi đối tác.'
    },
    {
      q: 'Chính sách hành lý ký gửi là gì?',
      a: 'Mỗi hành khách được mang theo tối đa 20kg hành lý ký gửi và 1 túi xách tay nhỏ (dưới 5kg). Hành lý quá khổ hoặc vượt trọng lượng có thể phải đóng thêm phí dịch vụ theo bảng giá tại bến xe.'
    },
    {
      q: 'Làm sao để khiếu nại về chất lượng dịch vụ?',
      a: 'Intercity Velocity luôn lắng nghe ý kiến của bạn. Bạn có thể gửi phản hồi trực tiếp qua ứng dụng, gọi hotline CSKH 1900 xxxx, hoặc gửi email tới support@velocity.travel. Chúng tôi cam kết phản hồi trong vòng 24 giờ làm việc.'
    }
  ];

  return (
    <section className="py-16 bg-surface-container-low">
      <div className="max-w-3xl mx-auto px-gutter">
        <div className="text-center mb-12">
          <h2 className="font-headline-lg text-headline-lg mb-4">Câu hỏi thường gặp (Top FAQs)</h2>
          <p className="text-on-surface-variant font-body-md text-body-md">Giải quyết nhanh các thắc mắc phổ biến nhất từ hành khách.</p>
        </div>
        <div className="space-y-4">
          {faqs.map((faq, index) => {
            const isOpen = openIndex === index;
            return (
              <div key={index} className="bg-white rounded-xl border border-outline-variant transition-all overflow-hidden">
                <button 
                  className="w-full px-6 py-5 flex items-center justify-between text-left group" 
                  onClick={() => setOpenIndex(isOpen ? null : index)}
                >
                  <span className={`font-label-md text-label-md transition-colors ${isOpen ? 'text-primary' : 'text-on-surface group-hover:text-primary'}`}>
                    {faq.q}
                  </span>
                  <span className={`material-symbols-outlined transition-transform text-outline ${isOpen ? 'rotate-180' : ''}`}>
                    expand_more
                  </span>
                </button>
                <div 
                  className="transition-all duration-300 ease-in-out" 
                  style={{ maxHeight: isOpen ? '500px' : '0px', opacity: isOpen ? 1 : 0 }}
                >
                  <div className="px-6 pb-6 text-on-surface-variant font-body-md text-body-md leading-relaxed">
                    <p>{faq.a}</p>
                  </div>
                </div>
              </div>
            );
          })}
        </div>
        <div className="mt-12 text-center">
          <button className="inline-flex items-center gap-2 text-primary font-bold hover:underline">
            Xem tất cả câu hỏi thường gặp
            <span className="material-symbols-outlined">arrow_forward</span>
          </button>
        </div>
      </div>
    </section>
  );
}
