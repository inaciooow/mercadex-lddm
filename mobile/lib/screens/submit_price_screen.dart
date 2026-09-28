import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/features/markets/data/markets_repository.dart';
import 'package:mercadex/features/markets/domain/market.dart';
import 'package:mercadex/features/products/data/products_repository.dart';
import 'package:mercadex/features/products/domain/product_deals.dart';
import 'package:mercadex/widgets/app_top_bar.dart';

class SubmitPriceScreen extends StatefulWidget {
  const SubmitPriceScreen({super.key, required this.productId});

  final String productId;

  @override
  State<SubmitPriceScreen> createState() => _SubmitPriceScreenState();
}

class _SubmitPriceScreenState extends State<SubmitPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Future<({ProductDeals product, List<MarketDetail> markets})> _data;
  MarketDetail? _market;

  @override
  void initState() {
    super.initState();
    _data = _loadData();
  }

  Future<({ProductDeals product, List<MarketDetail> markets})>
  _loadData() async {
    final product = await const ProductsRepository().getProductDeals(
      widget.productId,
    );
    const repository = MarketsRepository();
    final markets = await repository.getMarkets();
    final details = await Future.wait(
      markets.map((market) => repository.getMarket(market.id)),
    );
    return (product: product, markets: details);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    // Prototype only: close the form without saving or sending a price.
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Informar preço'),
      body: FutureBuilder<({ProductDeals product, List<MarketDetail> markets})>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Não foi possível carregar o formulário.'),
            );
          }

          final data = snapshot.data!;
          final branches = _market?.branches ?? const <MarketBranch>[];
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  data.product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text('Preço por ${data.product.packaging}'),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Supermercado'),
                  items: data.markets.map((market) {
                    return DropdownMenuItem(
                      value: market.id,
                      child: Text(market.name, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (id) {
                    setState(() {
                      _market = data.markets
                          .where((market) => market.id == id)
                          .firstOrNull;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um supermercado.' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  key: ValueKey(_market?.id),
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Unidade'),
                  hint: Text(
                    _market == null
                        ? 'Selecione o supermercado primeiro'
                        : branches.isEmpty
                        ? 'Nenhuma unidade disponível'
                        : 'Selecione uma unidade',
                  ),
                  items: branches.map((branch) {
                    return DropdownMenuItem(
                      value: branch.id,
                      child: Text(branch.name, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: branches.isEmpty ? null : (_) {},
                  validator: (value) =>
                      value == null ? 'Selecione uma unidade.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                    prefixText: 'R\$ ',
                    hintText: '4,29',
                  ),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    if (!RegExp(r'^\d+([,.]\d{1,2})?$').hasMatch(text)) {
                      return 'Informe um preço válido, como 4,29.';
                    }
                    final price = double.tryParse(text.replaceAll(',', '.'));
                    if (price == null || !price.isFinite || price <= 0) {
                      return 'O preço deve ser maior que zero.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: branches.isEmpty ? null : _submit,
                  child: const Text('Enviar preço'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
