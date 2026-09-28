import { BadRequestException, Injectable } from '@nestjs/common';
import { PriceObservationStatus } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class SearchService {
  constructor(private readonly prisma: PrismaService) {}

  async search(query: string) {
    const searchQuery = query?.trim();
    if (!searchQuery) {
      throw new BadRequestException('Query is required');
    }

    return this.prisma.product.findMany({
      where: {
        OR: [
          { name: { contains: searchQuery, mode: 'insensitive' } },
          { brand: { contains: searchQuery, mode: 'insensitive' } },
          { category: { contains: searchQuery, mode: 'insensitive' } },
          { tags: { has: searchQuery.toLowerCase() } },
        ],
        priceObservations: {
          some: { status: PriceObservationStatus.ACTIVE },
        },
      },
      select: { id: true, name: true, packaging: true },
      orderBy: { name: 'asc' },
    });
  }
}
