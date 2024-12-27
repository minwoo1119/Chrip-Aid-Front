import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/custom_post_list.dart';
import '../../common/component/custom_toggle_button.dart';
import '../../common/styles/colors.dart';
import '../../orphanage/layout/detail_page_layout.dart';
import '../../post/model/entity/post_request_entity.dart';
import '../../post/model/entity/post_reservation_entity.dart';
import '../../post/model/entity/post_thanks_entity.dart';
import '../model/state/admin_post_management_state.dart';
import '../viewmodel/admin_postmanagement_viewmodel.dart';

class AdminPostmanagementScreen extends ConsumerStatefulWidget {
  static String get routeName => 'postmanagement';

  AdminPostmanagementScreen({Key? key}) : super(key: key);

  @override
  _AdminPostmanagementScreenState createState() =>
      _AdminPostmanagementScreenState();
}

class _AdminPostmanagementScreenState
    extends ConsumerState<AdminPostmanagementScreen> {
  final selectedToggleProvider = StateProvider<int>((ref) => 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postManagementProvider.notifier).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postManagementProvider);
    final notifier = ref.read(postManagementProvider.notifier);
    final selectedIndex = ref.watch(selectedToggleProvider);

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '게시글 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: Colors.white,
      leadingColor: CustomColor.textReverseColor,
      child: Column(
        children: [
          SizedBox(height: 10.0),
          CustomToggleButton(
            options: ['Book', 'Request', 'Thanks'],
            onChanged: (index) {
              ref.read(selectedToggleProvider.notifier).state = index;
            },
          ),
          SizedBox(height: 6.0),
          Expanded(
            child: Builder(
              builder: (context) {
                List<dynamic>? data;

                if (selectedIndex == 0) {
                  data = state.reservationPosts;
                } else if (selectedIndex == 1) {
                  data = state.requestPosts;
                } else {
                  data = state.thanksPosts;
                }

                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text('게시글이 없습니다.'),
                  );
                }

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final post = data?[index];

                    if (post is PostReservationEntity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: CustomPostList(
                          id: post.reservationId,
                          postType: 'reservation',
                          title: "방문 예약 - ${post.reservationId}",
                          content: post.reason,
                          writtenAt: post.writeDate,
                          nickname: post.state,
                          onTap: () => _navigateToDetailPage(context, post.toJson()),
                          onDelete: () =>
                              notifier.deleteReservationPost(post.reservationId),
                        ),
                      );
                    } else if (post is PostRequestEntity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: CustomPostList(
                          id: post.requestId,
                          postType: 'request',
                          title: "물품 요청 - ${post.requestId}",
                          content: post.message,
                          writtenAt: "총 ${post.supportedCount}/${post.count}개",
                          nickname: post.state,
                          onTap: () => _navigateToDetailPage(context, post.toJson()),
                          onDelete: () => notifier.deleteRequestPost(post.requestId),
                        ),
                      );
                    } else if (post is PostThanksEntity) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: CustomPostList(
                          id: post.reviewId,
                          postType: 'review',
                          title: "기부 감사 - ${post.reviewId}",
                          content: post.content,
                          writtenAt: post.date,
                          nickname: post.name,
                          onTap: () => _navigateToDetailPage(context, post.toJson()),
                          onDelete: () => notifier.deleteThanksPost(post.reviewId),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink(); // 다른 타입은 무시
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, Map<String, dynamic> postData) {
    context.push(
      '/supervisor/postmanagement/postdetail',
      extra: postData,
    );
  }
}
