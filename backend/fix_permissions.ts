import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  console.log('Granting permissions...');
  await prisma.$executeRawUnsafe('GRANT USAGE ON SCHEMA public TO postgres, anon, authenticated, service_role;');
  await prisma.$executeRawUnsafe('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres, anon, authenticated, service_role;');
  await prisma.$executeRawUnsafe('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres, anon, authenticated, service_role;');
  
  // To ensure they can still insert/update, we might need to enable RLS or set policies, 
  // but if RLS is disabled on the tables (default via prisma db push), anon has full access 
  // if they have table privileges.
  console.log('Permissions granted successfully!');
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
