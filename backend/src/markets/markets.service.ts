import { Injectable, NotFoundException } from '@nestjs/common';
import { PriceObservationStatus } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class MarketsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.market.findMany({
      select: { id: true, name: true },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(marketId: string) {
    const market = await this.prisma.market.findUnique({
      where: { id: marketId },
      select: {
        id: true,
        name: true,
        branches: {
          select: {
            id: true,
            name: true,
            address: true,
            latitude: true,
            longitude: true,
          },
          orderBy: { name: 'asc' },
        },
      },
    });

    if (!market) {
      throw new NotFoundException('Market not found');
    }

    const observations = await this.prisma.priceObservation.findMany({
      where: {
        status: PriceObservationStatus.ACTIVE,
        branch: { marketId },
      },
      select: {
        product: { select: { id: true, name: true, packaging: true } },
      },
      orderBy: { product: { name: 'asc' } },
    });

    const products = [
      ...new Map(
        observations.map((observation) => [
          observation.product.id,
          observation.product,
        ]),
      ).values(),
    ];

    return { ...market, products };
  }
}
