import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/auth/view/login_screen.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/common/view/root_tab.dart';
import 'package:chrip_aid/common/view/splash_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_detail_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.watch(authProvider);
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
                name: OrphanageMapScreen.routeName,
                builder: (context, state) => const OrphanageMapScreen(),
              ),
              GoRoute(
                path: 'search',
                name: OrphanageSearchScreen.routeName,
                builder: (context, state) => const OrphanageSearchScreen(),
              ),
              GoRoute(
                path: 'detail',
                name: OrphanageDetailScreen.routeName,
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
        path: '/auth',
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: 'signup',
            name: SignUpScreen.routeName,
            builder: (context, state) => const SignUpScreen(),
          ),
        ],
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
