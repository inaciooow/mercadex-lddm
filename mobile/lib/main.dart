import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadex/core/routing/app_router.dart';
import 'package:mercadex/core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MercadexApp()));
}

class MercadexApp extends StatelessWidget {
  const MercadexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mercadex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
