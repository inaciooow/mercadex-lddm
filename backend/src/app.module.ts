import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { FavoritesModule } from './favorites/favorites.module';
import { ProductsModule } from './products/products.module';

@Module({
  imports: [AuthModule, FavoritesModule, ProductsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
