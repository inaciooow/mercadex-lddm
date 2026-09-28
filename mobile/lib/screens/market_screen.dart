import 'package:flutter/material.dart';
import 'package:mercadex/features/markets/data/markets_repository.dart';
import 'package:mercadex/features/markets/domain/market.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key, required this.marketId});

  final String marketId;

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final Future<MarketDetail> _market;

  @override
  void initState() {
    super.initState();
    _market = const MarketsRepository().getMarket(widget.marketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market')),
      body: FutureBuilder<MarketDetail>(
        future: _market,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Could not load market.'));
          }

          final market = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                market.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              Text('Branches', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...market.branches.map(
                (branch) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.storefront_outlined),
                    title: Text(branch.name),
                    subtitle: Text(branch.address),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
