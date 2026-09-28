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

    const observations = await this.prisma.priceObservation.findMany({
      where: {
        status: PriceObservationStatus.ACTIVE,
        product: {
          OR: [
            { name: { contains: searchQuery, mode: 'insensitive' } },
            { brand: { contains: searchQuery, mode: 'insensitive' } },
            { category: { contains: searchQuery, mode: 'insensitive' } },
          ],
        },
      },
      include: {
        product: { select: { id: true, name: true, packaging: true } },
        branch: {
          select: {
            id: true,
            name: true,
            address: true,
            market: { select: { id: true, name: true } },
          },
        },
      },
      orderBy: { observedAt: 'desc' },
    });

    return observations.map((observation) => ({
      id: observation.id,
      product: observation.product,
      market: observation.branch.market,
      branch: {
        id: observation.branch.id,
        name: observation.branch.name,
        address: observation.branch.address,
      },
      price: observation.price.toString(),
      observedAt: observation.observedAt,
    }));
  }
}
