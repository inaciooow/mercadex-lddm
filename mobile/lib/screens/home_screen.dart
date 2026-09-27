import 'package:flutter/material.dart';

import 'package:mercadex/widgets/app_top_bar.dart';
import 'package:mercadex/widgets/app_search_field.dart';
import 'package:mercadex/widgets/ad_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppTopBar(title: 'Mercadex'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [AppSearchField(), SizedBox(height: 16), AdBanner()],
        ),
      ),
    );
  }
}
