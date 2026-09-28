import 'package:flutter/material.dart';
import 'package:mercadex/core/theme/app_colors.dart';

class ProductAvatar extends StatelessWidget {
  const ProductAvatar({super.key, this.size = 52});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.seed.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(Icons.shopping_basket_outlined, color: AppColors.seed),
    );
  }
}
