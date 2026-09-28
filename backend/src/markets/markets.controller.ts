import { Controller, Get, Param } from '@nestjs/common';
import { MarketsService } from './markets.service';

@Controller('markets')
export class MarketsController {
  constructor(private readonly marketsService: MarketsService) {}

  @Get()
  findAll() {
    return this.marketsService.findAll();
  }

  @Get(':marketId')
  findOne(@Param('marketId') marketId: string) {
    return this.marketsService.findOne(marketId);
  }
}
