import 'package:chrip_aid/admin/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/admin/model/state/user_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/value_state/state/value_state.dart';
import '../../member/model/entity/user_detail_entity.dart';
import '../../orphanage/model/entity/orphanage_detail_entity.dart';
import '../../orphanage/model/entity/orphanage_entity.dart';
import '../model/service/admin_accountmanagement_service.dart';

final adminAccountManagementViewModelProvider = Provider((ref) => AdminAccountManagementViewmodel(ref));

class AdminAccountManagementViewmodel {
  Ref ref;
  late final AdminAccountManagementService _adminAccountManagementService;

  // 상태 관리 객체
  ValueStateNotifier<List<UserDetailEntity>> userState = UserListState();
  ValueStateNotifier<OrphanageEntity> userOrphanageListState = UserOrphanageListState();
  ValueStateNotifier<UserDetailEntity> userDetailState = UserDetailState();
  ValueStateNotifier<OrphanageDetailEntity> orphanageUserDetailState = UserOrphanageDetailState();

  AdminAccountManagementViewmodel(this.ref) {
    _adminAccountManagementService = ref.read(adminAccountManagementServiceProvider);
  }

  Future<void> getUserList() async {
    try {
      userState.loading();
      final List<UserDetailEntity> userList = await _adminAccountManagementService.getUserList();
      print('Received data from service: $userList'); // 서비스로부터 받은 데이터 확인
      userState.success(value: userList);
      print('State successfully updated to success with value: $userList');
    } catch (e) {
      userState.error(message: e.toString());
      print('Exception occurred while loading user list: $e');
    }
  }

  Future<void> getOrphanageUserList() async {
    try {
      userOrphanageListState.loading();
      print('Orphanage user list loading...');
      final orphanageList = await _adminAccountManagementService.getOrphanageUserList();
      userOrphanageListState.success(value: orphanageList);
      print('Orphanage user list successfully loaded: $orphanageList');
    } catch (e) {
      userOrphanageListState.error(message: e.toString());
      print('Exception occurred while loading orphanage user list: $e');
    }
  }

  Future<void> getUserDetailInfo(String userId) async {
    try {
      userDetailState.loading();
      print('Loading user details for ID: $userId');
      final userDetail = await _adminAccountManagementService.getUserById(userId);
      userDetailState.success(value: userDetail);
      print('User detail successfully loaded: $userDetail');
    } catch (e) {
      userDetailState.error(message: e.toString());
      print('Exception occurred while loading user details: $e');
    }
  }

  Future<void> getOrphanageUserDetailInfo(String orphanageUserId) async {
    try {
      orphanageUserDetailState.loading();
      print('Loading orphanage user details for ID: $orphanageUserId');
      final orphanageDetail = await _adminAccountManagementService.getOrphanageUserById(orphanageUserId);
      orphanageUserDetailState.success(value: orphanageDetail);
      print('Orphanage user detail successfully loaded: $orphanageDetail');
    } catch (e) {
      orphanageUserDetailState.error(message: e.toString());
      print('Exception occurred while loading orphanage user details: $e');
    }
  }
}
