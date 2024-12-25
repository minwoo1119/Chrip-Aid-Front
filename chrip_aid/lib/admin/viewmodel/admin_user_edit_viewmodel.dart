import 'package:chrip_aid/admin/model/service/admin_accountmanagement_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chrip_aid/admin/model/dto/user_edit_dto.dart';
import 'package:chrip_aid/admin/viewmodel/admin_accountmanagement_viewmodel.dart';

import '../../member/model/entity/user_detail_entity.dart';

final adminUserEditViewModelProvider = Provider<AdminUserEditViewModel>((ref) {
  final adminViewModel = ref.read(adminAccountManagementViewModelProvider);
  final adminService = ref.read(adminAccountManagementServiceProvider); // AdminAccountManagementService 가져오기
  return AdminUserEditViewModel(adminViewModel, adminService);
});


class AdminUserEditViewModel {
  final AdminAccountManagementViewmodel adminViewModel;
  final AdminAccountManagementService _service;

  AdminUserEditViewModel(this.adminViewModel, this._service);

  Future<UserDetailEntity?> getUserDetails(String userId) async {
    return await _service.getUserById(userId); // AdminAccountManagementService에서 데이터 로드
  }

  Future<void> updateUser(String userId, UserEditDto dto) async {
    await adminViewModel.updateUser(userId, dto);
  }
}
