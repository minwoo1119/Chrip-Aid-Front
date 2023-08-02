import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/common/view/root_tab.dart';
import 'package:chrip_aid/common/view/splash_screen.dart';
import 'package:chrip_aid/auth/view/login_screen.dart';
import 'package:chrip_aid/orphanage/orphanage_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider);
  return GoRouter(
    initialLocation: '/detailPage',
    routes: [
      GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (context, state) => const RootTab(),
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
        name: OrphanageDetailPage.routeName,
        builder: (context, state) => const OrphanageDetailPage(),
      ),
    ],
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
