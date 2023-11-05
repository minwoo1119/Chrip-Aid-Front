import 'package:chrip_aid/auth/provider/auth_provider.dart';
import 'package:chrip_aid/auth/provider/user_type_provider.dart';
import 'package:chrip_aid/auth/view/login_screen.dart';
import 'package:chrip_aid/auth/view/orphanage_sign_up_screen.dart';
import 'package:chrip_aid/auth/view/sign_up_screen.dart';
import 'package:chrip_aid/auth/view/user_sign_up_screen.dart';
import 'package:chrip_aid/common/view/root_tab.dart';
import 'package:chrip_aid/common/view/splash_screen.dart';
import 'package:chrip_aid/member/view/edit_member_info_screen.dart';
import 'package:chrip_aid/member/view/edit_user_info_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_detail_screen.dart';
import 'package:chrip_aid/post/view/orphanage_edit_post_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_map_screen.dart';
import 'package:chrip_aid/post/view/orphanage_post_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_search_screen.dart';
import 'package:chrip_aid/post/view/post_screen.dart';
import 'package:chrip_aid/post/view/user_post_screen.dart';
import 'package:chrip_aid/reservation/view/orphanage_reservation_screen.dart';
import 'package:chrip_aid/reservation/view/reservation_screen.dart';
import 'package:chrip_aid/reservation/view/user_reservation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  String redirectionByAuth(
    BuildContext context,
    GoRouterState state,
    String path,
  ) {
    if (ref.read(authorityProvider) == AuthorityType.user) return '$path/user';
    return '$path/orphanage';
  }

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
                routes: [
                  GoRoute(
                    path: 'basket',
                    name: OrphanageBasketScreen.routeName,
                    builder: (context, state) => const OrphanageBasketScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'reservation',
            name: ReservationScreen.routeName,
            redirect: (context, state) =>
                redirectionByAuth(context, state, "/reservation"),
            routes: [
              GoRoute(
                path: 'user',
                builder: (_, __) => const UserReservationScreen(),
              ),
              GoRoute(
                path: 'orphanage',
                builder: (_, __) => const OrphanageReservationScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'post',
            name: PostScreen.routeName,
            redirect: (context, state) {
              if (state.location.contains('edit')) return null;
              return redirectionByAuth(context, state, "/post");
            },
            routes: [
              GoRoute(
                path: 'user',
                builder: (_, __) => const UserPostScreen(),
              ),
              GoRoute(
                path: 'orphanage',
                builder: (_, __) => const OrphanagePostScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: OrphanageEditPostScreen.routeName,
                    redirect: (context, state) {
                      if (ref.read(authorityProvider) == AuthorityType.user) {
                        return '/post';
                      }
                      return null;
                    },
                    builder: (_, __) => const OrphanageEditPostScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'member',
            redirect: (context, state) {
              if (state.location.contains('edit')) return null;
              return '/member/edit';
            },
            routes: [
              GoRoute(
                path: 'edit',
                name: EditMemberInfoScreen.routeName,
                redirect: (context, state) =>
                    redirectionByAuth(context, state, "/member/edit"),
                routes: [
                  GoRoute(
                    path: 'user',
                    builder: (context, state) => const EditUserInfoScreen(),
                  ),
                  GoRoute(
                    path: 'orphanage',
                    // TODO : Create Edit Orphanage Info Screen
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
            name: SignUpScreen.routeName,
            redirect: (context, state) =>
                redirectionByAuth(context, state, "/auth/signup"),
            routes: [
              GoRoute(
                path: 'user',
                builder: (context, state) => const UserSignUpScreen(),
              ),
              GoRoute(
                path: 'orphanage',
                builder: (context, state) => const OrphanageSignUpScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    refreshListenable: auth,
    redirect: auth.redirectLogic,
  );
});
