import 'package:flutter/material.dart';
import 'package:mercadex/widgets/app_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: AppTopBar(title: 'Mercadex'));
  }
}
