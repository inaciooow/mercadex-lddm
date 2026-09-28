import 'package:go_router/go_router.dart';
import 'package:mercadex/screens/home_screen.dart';
import 'package:mercadex/screens/login_screen.dart';
import 'package:mercadex/screens/profile_screen.dart';
import 'package:mercadex/screens/search_results_screen.dart';
import 'package:mercadex/screens/to_be_implemented_screen.dart';
import 'package:mercadex/widgets/app_bottom_navigation.dart';

final appRouter = GoRouter(
  routes: [
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
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/scan',
      builder: (context, state) =>
          const ToBeImplementedScreen(title: 'Scan product'),
    ),
    GoRoute(
      path: '/market/:marketId',
      builder: (context, state) => const ToBeImplementedScreen(title: 'Market'),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) =>
          SearchResultsScreen(query: state.uri.queryParameters['query'] ?? ''),
    ),
  ],
);
