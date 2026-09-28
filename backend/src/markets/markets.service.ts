import { Injectable, NotFoundException } from '@nestjs/common';
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

    return market;
  }
}
