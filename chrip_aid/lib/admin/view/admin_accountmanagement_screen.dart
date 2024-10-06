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
import '../../member/model/entity/orphanage_user_entity.dart';
import '../../member/model/entity/user_detail_entity.dart';
import '../viewmodel/admin_accountmanagement_viewmodel.dart';

class AdminAccountmanagementScreen extends ConsumerStatefulWidget {
  static String get routeName => "accountmanagement";

  const AdminAccountmanagementScreen({Key? key}) : super(key: key);

  @override
  _AdminAccountmanagementScreenState createState() => _AdminAccountmanagementScreenState();
}

class _AdminAccountmanagementScreenState extends ConsumerState<AdminAccountmanagementScreen> {
  List<UserDetailEntity>? _cachedUserList;
  List<OrphanageUserEntity>? _cachedOrphanageUserList;

  @override
  void initState() {
    super.initState();

    // 페이지 초기 로드 시 User와 Orphanage User 데이터를 로드하여 캐시에 저장합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialData();
    });
  }

  void _fetchInitialData() async {
    final viewModel = ref.read(adminAccountManagementViewModelProvider);

    // 처음 데이터를 로드하여 캐시에 저장
    if (_cachedUserList == null) {
      final userListResult = await viewModel.getUserList();
      setState(() {
        _cachedUserList = userListResult;
      });
    }

    if (_cachedOrphanageUserList == null) {
      final orphanageUserListResult = await viewModel.getOrphanageUserList();
      setState(() {
        _cachedOrphanageUserList = orphanageUserListResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUserState = ref.watch(isUserFilterProvider);

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
      child: Column(
        children: [
          SizedBox(height: 10.0),
          CustomToggleButton(
            options: ['사용자', '보육원'],
            onChanged: (index) {
              ref.read(isUserFilterProvider.notifier).state = index == 0;
              setState(() {}); // 상태 변경 후 화면 다시 그리기
            },
          ),
          SizedBox(height: 6.0),
          Expanded(
            child: Builder(
              builder: (context) {
                if (isUserState) {
                  // 사용자 목록 출력
                  final data = _cachedUserList;
                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(), // 데이터가 없을 때 로딩 중
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: data.map((user) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomUserList(
                            name: user.name,
                            email: user.email,
                            phoneNumber: user.phoneNumber,
                            nickname: user.nickname,
                            onTap: () => _navigateToDetailPage(context, user),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  // 보육원 사용자 목록 출력
                  final data = _cachedOrphanageUserList;
                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(), // 데이터가 없을 때 로딩 중
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: data.map((orphanageUser) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: CustomUserList(
                            name: orphanageUser.name ?? 'N/A',
                            email: orphanageUser.email,
                            phoneNumber: orphanageUser.orphanageId.toString(),
                            nickname: orphanageUser.orphanageUserId,
                            onTap: () => _navigateToDetailPage(context, orphanageUser),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, Object userData) {
    if (userData is UserDetailEntity) {
      context.push(
        '/admin/accountmanagement/user/detail',
        extra: userData.toJson(),
      );
    } else if (userData is OrphanageUserEntity) {
      context.push(
        '/admin/accountmanagement/orphanageuser/detail',
        extra: userData.toJson(),
      );
    }
  }

}

final isUserFilterProvider = StateProvider<bool>((ref) => true);
