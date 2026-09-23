import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';
import { hash } from 'bcryptjs';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error('DATABASE_URL is required');
}

const prisma = new PrismaClient({
  adapter: new PrismaPg({ connectionString }),
});

type ProductSeed = {
  id: string;
  name: string;
  brand: string;
  packaging: string;
  category: string;
};

async function main() {
  const products: ProductSeed[] = JSON.parse(
    await readFile(join(__dirname, 'seed', 'products.json'), 'utf8'),
  );

  for (const product of products) {
    await prisma.product.upsert({
      where: { id: product.id },
      update: product,
      create: product,
    });
  }

  const passwordHash = await hash('admin', 12);

  await prisma.user.upsert({
    where: { email: 'admin@mercadex.local' },
    update: { role: 'ADMIN', isActive: true },
    create: {
      email: 'admin@mercadex.local',
      passwordHash,
      role: 'ADMIN',
    },
  });
}

void main()
  .catch((error: unknown) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(() => prisma.$disconnect());
