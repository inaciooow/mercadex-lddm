import {
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import type { AuthenticatedRequest } from '../auth/jwt-auth.guard';
import { FavoritesService } from './favorites.service';

@UseGuards(JwtAuthGuard)
@Controller('me/favorites')
export class FavoritesController {
  constructor(private readonly favoritesService: FavoritesService) {}

  @Get()
  findAll(@Req() request: AuthenticatedRequest) {
    return this.favoritesService.findAll(request.user.sub);
  }

  @Post(':productId')
  create(
    @Req() request: AuthenticatedRequest,
    @Param('productId') productId: string,
  ) {
    return this.favoritesService.create(request.user.sub, productId);
  }

  @Delete(':productId')
  @HttpCode(204)
  remove(
    @Req() request: AuthenticatedRequest,
    @Param('productId') productId: string,
  ) {
    return this.favoritesService.remove(request.user.sub, productId);
  }
}
