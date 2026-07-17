const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const authUsers = await prisma.$queryRawUnsafe("SELECT id, email, raw_user_meta_data FROM auth.users");
  
  for (const u of authUsers) {
    const name = u.raw_user_meta_data && u.raw_user_meta_data.full_name 
      ? u.raw_user_meta_data.full_name 
      : 'User';
      
    try {
      await prisma.user.create({
        data: {
          id: u.id,
          email: u.email,
          fullName: name,
          profile: { create: {} },
          wallet: { create: {} },
          loyalty: { create: {} }
        }
      });
      console.log('Restored user', u.email);
    } catch (e) {
      console.log('Failed to restore', u.email, e.message);
    }
  }
}

main().catch(console.error).finally(() => prisma.$disconnect());
