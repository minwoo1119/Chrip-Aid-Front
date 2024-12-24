import 'package:chrip_aid/common/component/custom_post_list.dart';
import 'package:chrip_aid/common/component/postlist/custom_account_list_with_delete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/custom_toggle_button.dart';
import '../../common/component/custom_user_list.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/sizes.dart';
import '../../member/model/entity/user_detail_entity.dart';
import '../../orphanage/layout/detail_page_layout.dart';
import '../model/state/admin_account_management_state.dart';
import 'admin_postmanagement_screen.dart';

class AdminAccountmanagementScreen extends ConsumerWidget {
  static String get routeName => "accountmanagement";
  const AdminAccountmanagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminAccountManagementProvider);
    final notifier = ref.read(adminAccountManagementProvider.notifier);

    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: '계정 관리',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [
        IconButton(
          onPressed: () => notifier.fetchInitialData(),
          icon: const Icon(Icons.refresh, size: kIconSmallSize),
          color: CustomColor.textReverseColor,
          splashRadius: kIconSmallSize,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
      child: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 10.0),
          CustomToggleButton(
            options: ['사용자', '보육원'],
            onChanged: (index) {
              ref.read(isUserFilterProvider.notifier).state = index == 0;
            },
          ),
          const SizedBox(height: 6.0),
          Expanded(
            child: Builder(
              builder: (context) {
                final isUserState = ref.watch(isUserFilterProvider);

                return isUserState
                    ? _buildUserList(state, notifier, context)
                    : _buildOrphanageList(state, notifier, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(AdminAccountManagementState state,
      AdminAccountManagementNotifier notifier, BuildContext context) {
    final data = state.userList;

    if (data == null || data.isEmpty) {
      return const Center(child: Text('사용자가 없습니다.'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final user = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: CustomUserList(
            name: user.name,
            email: user.email,
            phoneNumber: user.phoneNumber,
            nickname: user.nickname,
            onTap: () => _navigateToDetailPage(context, user, notifier),
            onDelete: () => _deleteUser(context, notifier, user.userId),
          ),
        );
      },
    );
  }

  Widget _buildOrphanageList(AdminAccountManagementState state,
      AdminAccountManagementNotifier notifier, BuildContext context) {
    final data = state.orphanageUserList;
    final orphanageData = state.orphanageList;

    if (data == null || data.isEmpty) {
      return const Center(child: Text('보육원 사용자가 없습니다.'));
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final orphanageUser = data[index];
        final orphanage = orphanageData?.firstWhere(
              (o) => o.orphanageId == orphanageUser.orphanageId.orphanageId,
          orElse: null,
        );
        final orphanageArea = orphanage?.address ?? 'N/A';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: CustomAccountListWithDelete(
            title: orphanageUser.name,
            content: orphanageUser.email,
            writtenAt: orphanageArea,
            nickname: "",
            id: orphanageUser.orphanageUserId,
            onDelete: () => _deleteOrphanageUser(
              context,
              notifier,
              orphanageUser.orphanageUserId,
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetailPage(
      BuildContext context,
      UserDetailEntity userData,
      AdminAccountManagementNotifier notifier) async {
    final bool? isDeleted = await context.push<bool>(
      '/admin/accountmanagement/user/detail',
      extra: userData,
    );

    if (isDeleted == true) {
      notifier.fetchInitialData();
    }
  }

  void _deleteUser(BuildContext context, AdminAccountManagementNotifier notifier,
      String userId) async {
    final confirm = await _showConfirmDialog(context, '사용자를 삭제하시겠습니까?');
    if (confirm == true) {
      await notifier.deleteUser(userId);
    }
  }

  void _deleteOrphanageUser(BuildContext context,
      AdminAccountManagementNotifier notifier, String orphanageUserId) async {
    final confirm =
    await _showConfirmDialog(context, '보육원 사용자를 삭제하시겠습니까?');
    if (confirm == true) {
      await notifier.deleteOrphanageUser(orphanageUserId);
    }
  }

  Future<bool?> _showConfirmDialog(BuildContext context, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
