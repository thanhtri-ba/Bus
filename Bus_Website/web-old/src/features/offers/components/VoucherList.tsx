import { VoucherCard } from './VoucherCard';

export function VoucherList() {
  const vouchers = [
    {
      id: 1,
      discount: '15%',
      unit: 'GIẢM',
      bgColorClass: 'bg-secondary',
      textColorClass: 'text-on-secondary',
      title: 'Ưu đãi chuyến đầu tiên',
      expiry: '15 Th10 2024',
      code: 'VELO15'
    },
    {
      id: 2,
      discount: '50k',
      unit: 'GIẢM',
      bgColorClass: 'bg-primary',
      textColorClass: 'text-on-primary',
      title: 'Khách hàng thân thiết',
      expiry: '20 Th10 2024',
      code: 'LOYAL50'
    },
    {
      id: 3,
      discount: 'FREE',
      unit: 'BỮA ĂN',
      bgColorClass: 'bg-tertiary',
      textColorClass: 'text-on-tertiary',
      title: 'Suất ăn nhẹ miễn phí',
      expiry: '30 Th11 2024',
      code: 'SNACKFREE'
    }
  ];

  return (
    <section className="mb-12">
      <div className="flex items-center justify-between mb-6">
        <h2 className="font-headline-md text-headline-md">Mã giảm giá khả dụng</h2>
        <a className="text-primary font-label-md hover:underline" href="#">Xem tất cả</a>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {vouchers.map(v => (
          <VoucherCard key={v.id} {...v} />
        ))}
      </div>
    </section>
  );
}
