import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/custom_post_list.dart';
import '../../common/component/custom_toggle_button.dart';
import '../../common/styles/colors.dart';
import '../../common/value_state/component/value_state_listener.dart';
import '../../common/value_state/state/value_state.dart';
import '../../orphanage/layout/detail_page_layout.dart';
import '../../post/model/entity/post_request_entity.dart';
import '../../post/model/entity/post_reservation_entity.dart';
import '../../post/model/entity/post_thanks_entity.dart';
import '../viewmodel/admin_postmanagement_viewmodel.dart';

class AdminPostmanagementScreen extends ConsumerStatefulWidget {
  static String get routeName => 'postmanagement';

  AdminPostmanagementScreen({Key? key}) : super(key: key);

  @override
  _AdminPostmanagementScreenState createState() => _AdminPostmanagementScreenState();
}

class _AdminPostmanagementScreenState extends ConsumerState<AdminPostmanagementScreen> {
  // StateProvider로 선택된 토글 값을 관리
  final selectedToggleProvider = StateProvider<int>((ref) => 0);

  @override
  void initState() {
    super.initState();
    // 처음에 모든 데이터를 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(adminPostManagementViewModelProvider);
      viewModel.getReservationPosts();
      viewModel.getRequestPosts();
      viewModel.getThanksPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(adminPostManagementViewModelProvider);
    final selectedIndex = ref.watch(selectedToggleProvider); // 선택된 토글 인덱스

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '게시글 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [],
      child: Column(
        children: [
          SizedBox(height: 10.0),
          CustomToggleButton(
            options: ['방문 예약', '물품 요청', '기부 감사'],
            onChanged: (index) {
              ref.read(selectedToggleProvider.notifier).state = index;
            },
          ),
          SizedBox(height: 6.0),
          Expanded(
            child: ValueStateListener(
              state: selectedIndex == 0
                  ? viewModel.reservationPostsState
                  : selectedIndex == 1
                  ? viewModel.requestPostsState
                  : viewModel.thanksPostsState,
              defaultBuilder: (_, state) => const Center(
                child: CircularProgressIndicator(), // 데이터 로드 중
              ),
              successBuilder: (_, state) {
                final data = state.value;

                if (data == null || data.isEmpty) {
                  return Center(
                    child: Text('데이터가 없습니다.'),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: data.map((post) {
                      if (post is PostReservationEntity) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomPostList(
                            id:post.reservationId,
                            postType: "reservation",
                            title: "방문 예약글 - ${post.reservationId}",
                            content: post.reason,
                            writtenAt: post.writeDate,
                            nickname: post.state,
                            onTap: () => _navigateToDetailPage(context, post.toJson()),
                          ),
                        );
                      } else if (post is PostRequestEntity) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomPostList(
                            id: post.requestId,
                            postType: "request",
                            title: "물품 요청 - ${post.requestId}",
                            content: post.message,
                            writtenAt: "총 ${post.supportedCount}/${post.count}개", // 작성일 추가 필요 시 수정
                            nickname: post.state,
                            onTap: () => _navigateToDetailPage(context, post.toJson()),
                          ),
                        );
                      } else if (post is PostThanksEntity) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomPostList(
                            id: post.reviewId,
                            postType: "review",
                            title: post.title,
                            content: post.content,
                            writtenAt: post.date,
                            nickname: post.name,
                            onTap: () => _navigateToDetailPage(context, post.toJson()),
                          ),
                        );
                      } else {
                        return SizedBox.shrink(); // 다른 타입일 경우 표시하지 않음
                      }
                    }).toList(),
                  ),
                );
              },
              errorBuilder: (_, error) {
                final errorMessage =
                error is ValueStateNotifier ? error.message : '알 수 없는 오류가 발생했습니다.';
                return Center(
                  child: Text('오류가 발생했습니다: $errorMessage'),
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

// isUser 필터 상태 관리
final isUserFilterProvider = StateProvider<bool>((ref) => true);
