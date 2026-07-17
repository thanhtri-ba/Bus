const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  await prisma.appConfig.upsert({
    where: { key: 'home_layout_order' },
    update: {},
    create: {
      key: 'home_layout_order',
      value: JSON.stringify(['search', 'destinations', 'promos', 'why_choose_us']),
      description: 'Thứ tự hiển thị các khối giao diện trên màn hình Home'
    }
  });

  console.log('home_layout_order seeded.');
}

main().catch(console.error).finally(() => prisma.$disconnect());
