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

  // ValueStateNotifier로 타입 설정
  ValueStateNotifier<List<UserDetailEntity>> userState = UserListState();
  ValueStateNotifier<List<OrphanageEntity>> userOrphanageListState = UserOrphanageListState();
  ValueStateNotifier<UserDetailEntity> userDetailState = UserDetailState();
  ValueStateNotifier<OrphanageDetailEntity> orphanageUserDetailState = UserOrphanageDetailState();

  AdminAccountManagementViewmodel(this.ref) {
    _adminAccountManagementService = ref.read(adminAccountManagementServiceProvider);
  }

  Future<void> getUserList() async {
    try {
      userState.loading();
      print('User list loading...');
      final response = await _adminAccountManagementService.getUserList();
      if (response.isSuccess && response.entity != null) {
        userState.success(value: response.entity!);
        print('User list successfully loaded: ${response.entity}');
      } else {
        userState.error(message: response.message ?? '알 수 없는 오류가 발생했습니다.');
        print('Error loading user list: ${response.message}');
      }
    } catch (e) {
      userState.error(message: e.toString());
      print('Exception occurred while loading user list: $e');
    }
  }


  Future<void> getOrphanageUserList() async {
    try {
      userOrphanageListState.loading();
      final response = await _adminAccountManagementService.getOrphanageUserList();
      if (response.isSuccess && response.entity != null) {
        userOrphanageListState.success(value: response.entity);
      } else {
        userOrphanageListState.error(message: response.message ?? '알 수 없는 오류가 발생했습니다.');
      }
    } catch (e) {
      userOrphanageListState.error(message: e.toString());
    }
  }

  // 특정 사용자 세부 정보 가져오기
  Future<void> getUserDetailInfo(String userId) async {
    try {
      userDetailState.loading();
      final response = await _adminAccountManagementService.getUserById(userId);
      if (response.isSuccess && response.entity != null) {
        userDetailState.success(value: response.entity!);
      } else {
        userDetailState.error(message: response.message ?? '알 수 없는 오류가 발생했습니다.');
      }
    } catch (e) {
      userDetailState.error(message: e.toString());
    }
  }

  // 특정 보육원 사용자 세부 정보 가져오기
  Future<void> getOrphanageUserDetailInfo(String orphanageUserId) async {
    try {
      orphanageUserDetailState.loading();
      final response = await _adminAccountManagementService.getOrphanageUserById(orphanageUserId);
      if (response.isSuccess && response.entity != null) {
        orphanageUserDetailState.success(value: response.entity);
      } else {
        orphanageUserDetailState.error(message: response.message ?? '알 수 없는 오류가 발생했습니다.');
      }
    } catch (e) {
      orphanageUserDetailState.error(message: e.toString());
    }
  }
}
