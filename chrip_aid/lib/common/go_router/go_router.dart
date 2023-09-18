import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/view/root_tab.dart';
import 'package:chrip_aid/common/view/splash_screen.dart';
import 'package:chrip_aid/auth/view/login_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_detail_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (context, state) => const RootTab(),
        routes: [
          GoRoute(
            path: 'orphanage',
            builder: (context, state) => const SplashScreen(),
            routes: [
              GoRoute(
                path: 'map',
                builder: (context, state) => const OrphanageMapScreen(),
              ),
              GoRoute(
                path: 'search',
                builder: (context, state) => const OrphanageSearchScreen(),
              ),
              GoRoute(
                path: 'detail',
                builder: (context, state) => const OrphanageDetailScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/detailPage',
        name: OrphanageDetailScreen.routeName,
        builder: (context, state) => const OrphanageDetailScreen(),
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
