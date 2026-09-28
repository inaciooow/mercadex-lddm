import 'package:go_router/go_router.dart';
import 'package:mercadex/screens/comparison_screen.dart';
import 'package:mercadex/screens/home_screen.dart';
import 'package:mercadex/screens/login_screen.dart';
import 'package:mercadex/screens/market_screen.dart';
import 'package:mercadex/screens/profile_screen.dart';
import 'package:mercadex/screens/product_screen.dart';
import 'package:mercadex/screens/search_results_screen.dart';
import 'package:mercadex/screens/shopping_list_screen.dart';
import 'package:mercadex/screens/submit_price_screen.dart';
import 'package:mercadex/screens/scanner_screen.dart';
import 'package:mercadex/widgets/app_bottom_navigation.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/compare',
      builder: (context, state) => const ComparisonScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppBottomNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shopping-list',
              builder: (context, state) => const ShoppingListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/scan', builder: (context, state) => const ScannerScreen()),
    GoRoute(
      path: '/market/:marketId',
      builder: (context, state) =>
          MarketScreen(marketId: state.pathParameters['marketId']!),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) =>
          SearchResultsScreen(query: state.uri.queryParameters['query'] ?? ''),
    ),
    GoRoute(
      path: '/product/:productId',
      builder: (context, state) =>
          ProductScreen(productId: state.pathParameters['productId']!),
    ),
    GoRoute(
      path: '/product/:productId/informar-preco',
      builder: (context, state) =>
          SubmitPriceScreen(productId: state.pathParameters['productId']!),
    ),
  ],
);
