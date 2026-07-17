const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  await prisma.appConfig.upsert({
    where: { key: 'home_slogan' },
    update: {},
    create: {
      key: 'home_slogan',
      value: 'Hôm nay bạn\\nmuốn đi đâu?',
      description: 'Slogan chính trên màn hình Home'
    }
  });

  await prisma.appConfig.upsert({
    where: { key: 'home_banner_url' },
    update: {},
    create: {
      key: 'home_banner_url',
      value: 'https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&w=1000&q=80',
      description: 'Ảnh nền phía sau header trang Home'
    }
  });

  console.log('App configs seeded.');
}

main().catch(console.error).finally(() => prisma.$disconnect());
