const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
async function main() {
  await prisma.$executeRawUnsafe('CREATE POLICY "Allow public update app_configs" ON "app_configs" FOR UPDATE USING (true);');
  console.log('UPDATE policy created');
}
main().finally(() => prisma.$disconnect());
