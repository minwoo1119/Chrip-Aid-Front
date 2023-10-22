import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/auth/provider/user_type_provider.dart';
import 'package:chrip_aid/auth/view/login_screen.dart';
import 'package:chrip_aid/auth/view/orphanage_sign_up_screen.dart';
import 'package:chrip_aid/auth/view/user_sign_up_screen.dart';
import 'package:chrip_aid/common/view/root_tab.dart';
import 'package:chrip_aid/common/view/splash_screen.dart';
import 'package:chrip_aid/member/view/edit_user_info_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_detail_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  final authority = ref.watch(authorityProvider);
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
          GoRoute(
            path: 'member',
            redirect: (context, state) {
              if (state.location.contains('edit')) return null;
              return '/member/edit';
            },
            builder: (context, state) => const SplashScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'editMember',
                redirect: (context, state) {
                  if (authority == AuthorityType.user) {
                    return '/member/edit/user';
                  }
                  return '/member/edit/orphanage';
                },
                builder: (context, state) => const SplashScreen(),
                routes: [
                  GoRoute(
                    path: 'user',
                    builder: (context, state) => const EditUserInfoScreen(),
                  ),
                  GoRoute(
                    path: 'orphanage',
                    builder: (context, state) => const EditUserInfoScreen(),
                  ),
                ],
              )
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
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) {
          if (state.location.contains('signup')) return null;
          return '/auth/login';
        },
        routes: [
          GoRoute(
            path: 'login',
            name: LoginScreen.routeName,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'signup',
            name: 'signup',
            builder: (context, state) => const SplashScreen(),
            redirect: (context, state) => authority == AuthorityType.user
                ? '/auth/signup/user'
                : '/auth/signup/orphanage',
            routes: [
              GoRoute(
                path: 'user',
                name: UserSignUpScreen.routeName,
                builder: (context, state) => const UserSignUpScreen(),
              ),
              GoRoute(
                path: 'orphanage',
                name: OrphanageSignUpScreen.routeName,
                builder: (context, state) => const OrphanageSignUpScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/detailPage/Basket',
        name: OrphanageBasketScreen.routeName,
        builder: (context, state) => const OrphanageBasketScreen(),
      ),
    ],
    refreshListenable: auth,
    redirect: auth.redirectLogic,
  );
});
