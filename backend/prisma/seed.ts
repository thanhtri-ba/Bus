import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  console.log('Starting seed...');
  console.log('Cleaning up existing data...');
  await prisma.user.deleteMany();
  await prisma.tripSchedule.deleteMany();
  await prisma.trip.deleteMany();
  await prisma.route.deleteMany();
  await prisma.station.deleteMany();
  await prisma.city.deleteMany();
  await prisma.province.deleteMany();
  await prisma.busAgent.deleteMany();
  await prisma.promotion.deleteMany();

  // 1. Create User & Wallet
  const user = await prisma.user.create({
    data: {
      email: 'admin@busz.com',
      fullName: 'Admin BusZ',
      wallet: {
        create: { balance: 1000000 },
      },
      loyalty: {
        create: { points: 500, tier: 'Gold' },
      },
    },
  });
  console.log('Created user:', user.email);

  // 2. Create Location Data
  const province = await prisma.province.create({
    data: { name: 'Việt Nam' },
  });

  const cityConfigs = [
    { name: 'TP.HCM', image: 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=800&q=80', sub: 'Thành phố mang tên Bác', isPopular: true },
    { name: 'Hà Nội', image: 'https://images.unsplash.com/photo-1599708153386-62bf3f034b79?auto=format&fit=crop&w=800&q=80', sub: 'Thủ đô ngàn năm', isPopular: true },
    { name: 'Đà Lạt', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Ho_Xuan_Huong%2C_Da_Lat.jpg/960px-Ho_Xuan_Huong%2C_Da_Lat.jpg', sub: 'Thành phố ngàn hoa', isPopular: true },
    { name: 'Nha Trang', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Nha_Trang_beach.jpg/960px-Nha_Trang_beach.jpg', sub: 'Biển xanh ngọc bích', isPopular: true },
    { name: 'Vũng Tàu', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Vung_Tau_beach.jpg/960px-Vung_Tau_beach.jpg', sub: 'Thành phố biển', isPopular: true },
    { name: 'Cần Thơ', image: null, sub: null, isPopular: false },
    { name: 'Sapa', image: null, sub: null, isPopular: false },
    { name: 'Hội An', image: null, sub: null, isPopular: false },
    { name: 'Phú Quốc', image: null, sub: null, isPopular: false },
    { name: 'Đà Nẵng', image: null, sub: null, isPopular: false },
  ];
  
  const cities = await Promise.all(
    cityConfigs.map((c) =>
      prisma.city.create({ data: { name: c.name, provinceId: province.id, isPopular: c.isPopular, image: c.image, subtitle: c.sub } })
    )
  );
  console.log(`Created ${cities.length} cities`);

  // Create 5 stations per city (100 total)
  let stationCount = 0;
  for (const city of cities) {
    for (let i = 1; i <= 5; i++) {
      await prisma.station.create({
        data: {
          name: `Bến xe ${city.name} ${i}`,
          cityId: city.id,
          isPopular: i === 1, // First station is popular
        },
      });
      stationCount++;
    }
  }
  console.log(`Created ${stationCount} stations`);

  // 3. Create Bus Agents (10 total)
  const agentNames = ['Phương Trang', 'Thành Bưởi', 'Kumho Samco', 'Hoàng Long', 'Mai Linh', 'Hải Vân', 'Hưng Thành', 'Sao Việt', 'Hoa Mai', 'Toàn Thắng'];
  const agents = await Promise.all(
    agentNames.map((name) =>
      prisma.busAgent.create({
        data: { name, rating: 4.8, reviewCount: 120 },
      })
    )
  );
  console.log(`Created ${agents.length} bus agents`);

  // 4. Create Routes
  const routeConfigs = [
    { from: 'TP.HCM', to: 'Đà Lạt', price: 180000, duration: 420, color: '#0796A8', isPopular: true },
    { from: 'TP.HCM', to: 'Nha Trang', price: 220000, duration: 540, color: '#9B51E0', isPopular: true },
    { from: 'TP.HCM', to: 'Vũng Tàu', price: 90000, duration: 120, color: '#27AE60', isPopular: true },
    { from: 'Hà Nội', to: 'Sapa', price: 250000, duration: 360, color: '#F2994A', isPopular: true },
  ];

  for (const rc of routeConfigs) {
    const fromCity = cities.find(c => c.name === rc.from);
    const toCity = cities.find(c => c.name === rc.to);
    
    if (fromCity && toCity) {
      const route = await prisma.route.create({
        data: {
          departureCityId: fromCity.id,
          arrivalCityId: toCity.id,
          isPopular: rc.isPopular,
          color: rc.color,
          basePrice: rc.price,
          durationMins: rc.duration,
        },
      });

      // Create 2 trips per route
      for (let i = 0; i < 2; i++) {
        const trip = await prisma.trip.create({
          data: {
            busAgentId: agents[i % agents.length].id,
            routeId: route.id,
            busClass: 'EXECUTIVE',
          },
        });

        const schedule = await prisma.tripSchedule.create({
          data: {
            tripId: trip.id,
            departureTime: new Date(new Date().getTime() + 24 * 60 * 60 * 1000 * i), // +i days
            arrivalTime: new Date(new Date().getTime() + (24 * 60 + rc.duration) * 60 * 1000 * i),
            durationMins: rc.duration,
          },
        });
        
        // Add Price
        await prisma.tripPrice.create({
          data: {
            tripScheduleId: schedule.id,
            seatClass: 'ECONOMY',
            price: rc.price,
          }
        });

        // Create 6 seats per schedule
        for (let s = 1; s <= 6; s++) {
          await prisma.seat.create({
            data: {
              tripScheduleId: schedule.id,
              seatNumber: `A${s}`,
            },
          });
        }
      }
    }
  }
  console.log('Created routes, trips and seats');

  // 5. Create Promotions
  await prisma.promotion.create({
    data: {
      code: 'WELCOME50',
      title: '50% Off First Ride',
      discountPct: 50.0,
      validUntil: new Date('2027-01-01'),
    },
  });
  console.log('Created promotions');

  console.log('Seed completed successfully!');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
