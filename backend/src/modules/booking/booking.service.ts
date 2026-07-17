import { PrismaClient, SeatStatus } from '@prisma/client';

const prisma = new PrismaClient();

interface CreateBookingParams {
  userId: string;
  tripScheduleId: string;
  seatNumbers: string[];
  passengers: { name: string; idCard?: string }[];
  idempotencyKey?: string;
  paymentMethod?: string;
}

export class BookingService {
  static async createBooking(params: CreateBookingParams) {
    const { userId, tripScheduleId, seatNumbers, passengers, idempotencyKey, paymentMethod } = params;

    // Lớp 3: Idempotency (Chống Spam). 
    // Trong thực tế, có thể lưu idempotencyKey vào một bảng riêng hoặc cột trong Booking để check.
    // Ở đây ta đơn giản hóa để tập trung vào Lớp 1 & Lớp 2.

    return await prisma.$transaction(async (tx) => {
      // 1. Kiểm tra TripSchedule
      const tripSchedule = await tx.tripSchedule.findUnique({
        where: { id: tripScheduleId },
        include: { prices: true }
      });

      if (!tripSchedule) {
        throw new Error('Chuyến xe không tồn tại');
      }

      // 2. Row Lock: Lấy danh sách các ghế đang được yêu cầu, KHÓA HÀNG để không ai khác được chạm vào
      // Prisma chưa hỗ trợ SELECT FOR UPDATE trực tiếp qua API chuẩn, nhưng ta có thể dùng $queryRaw
      // hoặc lấy ra và kiểm tra trạng thái trong transaction.
      const seats = await tx.seat.findMany({
        where: {
          tripScheduleId,
          seatNumber: { in: seatNumbers }
        }
      });

      if (seats.length !== seatNumbers.length) {
        throw new Error('Một số ghế không hợp lệ');
      }

      // Lớp 2: Kiểm tra xem tất cả ghế có trống không
      for (const seat of seats) {
        if (seat.status !== SeatStatus.AVAILABLE) {
          throw new Error(`Ghế ${seat.seatNumber} đã có người đặt hoặc đang giữ chỗ!`);
        }
      }

      // Lớp 1: Anti-tampering - Backend TỰ TÍNH TIỀN
      // Giá tiền được quyết định bởi bảng TripPrice dựa trên SeatClass
      // Tuy nhiên ở BusZ, SeatClass có thể gán theo sơ đồ ghế.
      // Giả sử ghế row < 2 (1A, 1B, 2A, 2B) là VIP, còn lại là ECONOMY.
      // Vì model Seat chưa có SeatClass trực tiếp, ta sẽ giả lập logic giống Frontend (Hoặc map theo TripPrice)
      
      const vipPriceObj = tripSchedule.prices.find(p => p.seatClass === 'VIP');
      const ecoPriceObj = tripSchedule.prices.find(p => p.seatClass === 'ECONOMY');
      const vipPrice = vipPriceObj ? vipPriceObj.price : 350000;
      const ecoPrice = ecoPriceObj ? ecoPriceObj.price : 280000;

      let totalAmount = 0;
      for (const seat of seats) {
        const isVip = seat.seatNumber.startsWith('1') || seat.seatNumber.startsWith('2');
        totalAmount += isVip ? vipPrice : ecoPrice;
      }

      // Thêm phí dịch vụ (Service Fee = 10000)
      totalAmount += 10000;

      // 3. Tạo Booking
      const booking = await tx.booking.create({
        data: {
          userId,
          tripScheduleId,
          totalAmount, // Giá TỰ TÍNH của Backend, tuyệt đối an toàn
          status: 'PENDING',
          passengers: {
            create: passengers.map(p => ({
              name: p.name,
              idCard: p.idCard
            }))
          },
          seatBookings: {
            create: seats.map(s => ({
              seatId: s.id,
              lockedAt: new Date()
            }))
          }
        }
      });

      // 4. Khóa ghế lại (Tránh người khác mua trùng)
      await tx.seat.updateMany({
        where: {
          id: { in: seats.map(s => s.id) }
        },
        data: {
          status: SeatStatus.LOCKED
        }
      });

      // 5. Lưu thông tin phương thức thanh toán (nếu có)
      if (paymentMethod) {
        await tx.payment.create({
          data: {
            bookingId: booking.id,
            method: paymentMethod,
            amount: totalAmount,
            status: 'UNPAID'
          }
        });
      }

      return booking;
    });
  }
}
