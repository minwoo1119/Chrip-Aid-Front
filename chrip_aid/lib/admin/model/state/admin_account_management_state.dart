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
}

final adminAccountManagementProvider =
StateNotifierProvider<AdminAccountManagementNotifier, AdminAccountManagementState>(
      (ref) {
    final viewModel = ref.read(adminAccountManagementViewModelProvider);
    return AdminAccountManagementNotifier(viewModel);
  },
);
