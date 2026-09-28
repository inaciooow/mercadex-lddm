import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mercadex/features/home/presentation/home_products_provider.dart';
import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/app_search_field.dart';
import 'package:mercadex/widgets/ad_banner.dart';
import 'package:mercadex/widgets/home_product_section.dart';
import 'package:mercadex/widgets/top_markets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentProducts = ref.watch(recentProductsProvider);
    final hotTodayProducts = ref.watch(hotTodayProductsProvider);

    return Scaffold(
      appBar: const AppTopBar(title: 'Mercadex'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          AppSearchField(
            onSubmitted: (query) {
              final searchQuery = query.trim();
              if (searchQuery.isEmpty) {
                return;
              }

              context.push(
                '/search?query=${Uri.encodeQueryComponent(searchQuery)}',
              );
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => context.push('/scan'),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Escanear produto'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const AdBanner(),
          const SizedBox(height: 24),
          const TopMarkets(),
          const SizedBox(height: 24),
          HomeProductSection(
            title: 'Destaques de hoje',
            products: hotTodayProducts,
            emptyMessage: 'Nenhum produto disponível.',
          ),
          const SizedBox(height: 24),
          HomeProductSection(
            title: 'Pesquisados recentemente',
            products: recentProducts,
            emptyMessage: 'Pesquise e abra um produto para vê-lo aqui.',
          ),
        ],
      ),
    );
  }
}
