import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../member/model/entity/orphanage_member_entity.dart';
import '../../../member/model/entity/orphanage_user_entity.dart';
import '../../../member/model/entity/user_detail_entity.dart';
import '../../viewmodel/admin_accountmanagement_viewmodel.dart';

class AdminAccountManagementState {
  final List<UserDetailEntity>? userList;
  final List<OrphanageUserEntity>? orphanageUserList;
  final List<OrphanageMemberEntity>? orphanageList;
  final bool isLoading;

  AdminAccountManagementState({
    this.userList,
    this.orphanageUserList,
    this.orphanageList,
    this.isLoading = false,
  });

  AdminAccountManagementState copyWith({
    List<UserDetailEntity>? userList,
    List<OrphanageUserEntity>? orphanageUserList,
    List<OrphanageMemberEntity>? orphanageList,
    bool? isLoading,
  }) {
    return AdminAccountManagementState(
      userList: userList ?? this.userList,
      orphanageUserList: orphanageUserList ?? this.orphanageUserList,
      orphanageList: orphanageList ?? this.orphanageList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AdminAccountManagementNotifier
    extends StateNotifier<AdminAccountManagementState> {
  final AdminAccountManagementViewmodel viewModel;

  AdminAccountManagementNotifier(this.viewModel)
      : super(AdminAccountManagementState(isLoading: true)) {
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    state = state.copyWith(isLoading: true);

    try {
      final userList = await viewModel.getUserList();
      final orphanageUserList = await viewModel.getOrphanageUserList();
      final orphanageList = await viewModel.getOrphanageList();

      state = state.copyWith(
        userList: userList,
        orphanageUserList: orphanageUserList,
        orphanageList: orphanageList,
        isLoading: false,
      );
    } catch (e) {
      print('데이터 로드 중 오류: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      // 서버에서 사용자 삭제
      await viewModel.deleteUser(userId);
      // 현재 상태의 사용자 리스트 갱신
      final updatedUserList = state.userList?.where((user) => user.userId != userId).toList();
      state = state.copyWith(userList: updatedUserList);

      print('사용자 삭제 성공');
    } catch (e) {
      print('사용자 삭제 중 오류: $e');
    }
  }

  Future<void> deleteOrphanageUser(String orphanageUserId) async {
    try {
      // 서버에서 보육원 사용자 삭제
      await viewModel.deleteOrphanageUser(orphanageUserId);
      // 현재 상태의 보육원 사용자 리스트 갱신
      final updatedOrphanageUserList = state.orphanageUserList
          ?.where((user) => user.orphanageUserId != orphanageUserId)
          .toList();
      state = state.copyWith(orphanageUserList: updatedOrphanageUserList);

      print('보육원 사용자 삭제 성공');
    } catch (e) {
      print('보육원 사용자 삭제 중 오류: $e');
    }
  }
}


final adminAccountManagementProvider =
StateNotifierProvider<AdminAccountManagementNotifier, AdminAccountManagementState>(
      (ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider);
    return AdminAccountManagementNotifier(viewModel);
  },
);
