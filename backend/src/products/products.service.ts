import { Injectable, NotFoundException } from '@nestjs/common';
import { PriceObservationStatus } from '@prisma/client';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProductsService {
  constructor(private readonly prisma: PrismaService) {}

  findAll() {
    return this.prisma.product.findMany({
      orderBy: { name: 'asc' },
    });
  }

  async findDeals(productId: string) {
    const product = await this.prisma.product.findUnique({
      where: { id: productId },
      select: {
        id: true,
        name: true,
        packaging: true,
        priceObservations: {
          where: { status: PriceObservationStatus.ACTIVE },
          select: {
            id: true,
            price: true,
            observedAt: true,
            branch: {
              select: {
                id: true,
                name: true,
                market: { select: { id: true, name: true } },
              },
            },
          },
          orderBy: { price: 'asc' },
        },
      },
    });

    if (!product) {
      throw new NotFoundException('Product not found');
    }

    return {
      id: product.id,
      name: product.name,
      packaging: product.packaging,
      deals: product.priceObservations.map((observation) => ({
        id: observation.id,
        price: observation.price.toString(),
        observedAt: observation.observedAt,
        market: observation.branch.market,
        branch: {
          id: observation.branch.id,
          name: observation.branch.name,
        },
      })),
    };
  }
}
