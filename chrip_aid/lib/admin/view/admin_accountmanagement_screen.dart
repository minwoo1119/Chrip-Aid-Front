import 'package:chrip_aid/common/component/custom_toggle_button.dart';
import 'package:chrip_aid/common/component/custom_user_list.dart';
import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/common/value_state/component/value_state_listener.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/value_state/state/value_state.dart';
import '../../member/model/entity/user_detail_entity.dart';
import '../viewmodel/admin_accountmanagement_viewmodel.dart';

class AdminAccountmanagementScreen extends ConsumerStatefulWidget {
  static String get routeName => "accountmanagement";

  const AdminAccountmanagementScreen({Key? key}) : super(key: key);

  @override
  _AdminAccountmanagementScreenState createState() => _AdminAccountmanagementScreenState();
}

class _AdminAccountmanagementScreenState extends ConsumerState<AdminAccountmanagementScreen> {
  @override
  void initState() {
    super.initState();

    // 데이터 로드 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isUserState = ref.read(isUserFilterProvider);
      final viewModel = ref.read(adminAccountManagementViewModelProvider);

      if (isUserState) {
        viewModel.getUserList();
      } else {
        viewModel.getOrphanageUserList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isUserState = ref.watch(isUserFilterProvider);
    final viewModel = ref.read(adminAccountManagementViewModelProvider);

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.search, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: ValueStateListener(
        state: isUserState ? viewModel.userState : viewModel.userOrphanageListState,  // API 요청 결과 상태
        defaultBuilder: (_, state) => const Center(
          child: CircularProgressIndicator(),
        ),
        successBuilder: (_, state) {
          final List<UserDetailEntity>? data = state.value as List<UserDetailEntity>?;

          if (data == null || data.isEmpty) {
            return Center(
              child: Text('데이터가 없습니다.'),
            );
          }

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  CustomToggleButton(
                    options: ['사용자', '보육원'],
                    onChanged: (index) {
                      ref.read(isUserFilterProvider.notifier).state = index == 0;

                      // Toggle 버튼 값 변경 시 데이터 다시 불러오기
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (index == 0) {
                          viewModel.getUserList();
                        } else {
                          viewModel.getOrphanageUserList();
                        }
                      });
                    },
                  ),
                  SizedBox(height: 6.0),
                  Column(
                    children: data.map((user) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: CustomUserList(
                          name: user.name,
                          email: user.email,
                          phoneNumber: user.phone,
                          nickname: user.nickName,
                          onTap: () => _navigateToDetailPage(context, user),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
        errorBuilder: (_, error) {
          // 오류 메시지를 표시하도록 수정
          final errorMessage = error is ValueStateNotifier ? error.message : '알 수 없는 오류가 발생했습니다.';
          return Center(
            child: Text('오류가 발생했습니다: $errorMessage'),
          );
        },
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, UserDetailEntity userData) {
    context.push(
      '/supervisor/accountmanagement/detail',
      extra: userData,
    );
  }
}

final isUserFilterProvider = StateProvider<bool>((ref) => true);
