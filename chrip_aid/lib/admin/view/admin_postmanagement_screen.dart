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
import '../viewmodel/admin_postmanagement_viewmodel.dart';

class AdminPostmanagementScreen extends ConsumerWidget {
  static String get routeName => 'postmanagement';

  // StateProvider로 선택된 토글 값을 관리
  final selectedToggleProvider = StateProvider<int>((ref) => 0);

  AdminPostmanagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(adminPostManagementViewModelProvider);
    final selectedIndex = ref.watch(selectedToggleProvider); // 선택된 토글 인덱스

    // 선택된 인덱스에 따라 데이터를 로드
    void _fetchDataBasedOnToggle(int index) {
      if (index == 0) {
        viewModel.getReservationPosts();
      } else if (index == 1) {
        viewModel.getRequestPosts();
      } else {
        viewModel.getThanksPosts();
      }
    }

    // 처음에 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDataBasedOnToggle(selectedIndex);
    });

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
              _fetchDataBasedOnToggle(index); // Toggle 변경 시 데이터 다시 로드
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
                final List<Map<String, dynamic>>? data =
                state.value as List<Map<String, dynamic>>?;
                if (data == null || data.isEmpty) {
                  return Center(
                    child: Text('데이터가 없습니다.'),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: data.map((post) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: CustomPostList(
                          title: post['title'],
                          content: post['content'],
                          writtenAt: post['writtenAt'],
                          nickname: post['nickname'],
                          onTap: () => _navigateToDetailPage(context, post),
                        ),
                      );
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
