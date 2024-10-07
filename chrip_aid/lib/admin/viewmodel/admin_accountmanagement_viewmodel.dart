import 'package:chrip_aid/admin/model/dto/orphanage_user_add_dto.dart';
import 'package:chrip_aid/admin/model/dto/orphanage_user_edit_dto.dart';
import 'package:chrip_aid/admin/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/admin/model/state/user_detail_state.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/value_state/state/value_state.dart';
import '../../member/model/entity/orphanage_user_entity.dart';
import '../../member/model/entity/user_detail_entity.dart';
import '../../orphanage/model/entity/orphanage_detail_entity.dart';
import '../model/dto/user_edit_dto.dart';
import '../model/repository/admin_accountmanager_repository.dart';
import '../model/service/admin_accountmanagement_service.dart';

final adminAccountManagementViewModelProvider =
Provider((ref) => AdminAccountManagementViewmodel(ref));

class AdminAccountManagementViewmodel {
  Ref ref;
  late final AdminAccountManagementService _adminAccountManagementService;

  // 상태 관리 객체
  ValueStateNotifier<List<UserDetailEntity>> userState = UserListState();
  ValueStateNotifier<List<OrphanageUserEntity>> userOrphanageListState =
  UserOrphanageListState();
  ValueStateNotifier<UserDetailEntity> userDetailState = UserDetailState();
  ValueStateNotifier<OrphanageDetailEntity> orphanageUserDetailState =
  UserOrphanageDetailState();

  // 캐시된 데이터 리스트
  List<UserDetailEntity>? _cachedUserList;
  List<OrphanageUserEntity>? _cachedOrphanageUserList;

  AdminAccountManagementViewmodel(this.ref) {
    _adminAccountManagementService =
        ref.read(adminAccountManagementServiceProvider);
  }

  // 사용자 정보 추가
  Future<void> createUser(UserDto dto) async {
    try {
      await _adminAccountManagementService.createUser(dto);
      print('User created successfully');
    } catch (e) {
      print('Exception occurred while creating user: $e');
      throw Exception('Failed to create user');
    }
  }

  // 사용자 정보 수정
  Future<void> updateUser(String id, UserEditDto dto) async {
    try {
      await _adminAccountManagementService.updateUser(id, dto);
      print('User updated successfully');
    } catch (e) {
      print('Exception occurred while updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  // 사용자 정보 삭제
  Future<void> deleteUser(String id) async {
    try {
      await _adminAccountManagementService.deleteUser(id);
      print('User deleted successfully');
    } catch (e) {
      print('Exception occurred while deleting user: $e');
      throw Exception('Failed to delete user');
    }
  }

  // 사용자 닉네임으로 조회
  Future<void> getUserByNickname(String nickname) async {
    try {
      userDetailState.loading();
      final userDetail = await _adminAccountManagementService.getUserByNickname(nickname);
      userDetailState.success(value: userDetail);
      print('User detail loaded successfully by nickname: $nickname');
    } catch (e) {
      userDetailState.error(message: e.toString());
      print('Exception occurred while loading user by nickname: $e');
    }
  }

  // 사용자 목록 가져오기
  Future<List<UserDetailEntity>> getUserList() async {
    try {
      if (_cachedUserList != null) {
        print('Returning cached user list');
        userState.success(value: _cachedUserList!);
        return _cachedUserList!;
      }

      userState.loading();
      final List<UserDetailEntity> userList =
      await _adminAccountManagementService.getUserList();
      print('Received data from service: $userList');
      userState.success(value: userList);
      _cachedUserList = userList;

      return userList;
    } catch (e) {
      userState.error(message: e.toString());
      print('Exception occurred while loading user list: $e');
      rethrow;
    }
  }

  // 보육원 사용자 목록 가져오기
  Future<List<OrphanageUserEntity>> getOrphanageUserList() async {
    try {
      if (_cachedOrphanageUserList != null) {
        print('Returning cached orphanage user list');
        userOrphanageListState.success(value: _cachedOrphanageUserList!);
        return _cachedOrphanageUserList!;
      }

      userOrphanageListState.loading();
      print('Orphanage user list loading...');
      final List<OrphanageUserEntity> orphanageList =
      await _adminAccountManagementService.getOrphanageUserList();
      userOrphanageListState.success(value: orphanageList);
      _cachedOrphanageUserList = orphanageList;

      return orphanageList;
    } catch (e) {
      userOrphanageListState.error(message: e.toString());
      print('Exception occurred while loading orphanage user list: $e');
      rethrow;
    }
  }

  // 보육원 사용자 추가
  Future<void> createOrphanageUser(OrphanageUserAddDto dto) async {
    try {
      await _adminAccountManagementService.createOrphanageUser(dto);
      print('Orphanage user created successfully');
    } catch (e) {
      print('Exception occurred while creating orphanage user: $e');
      throw Exception('Failed to create orphanage user');
    }
  }

  // 보육원 사용자 수정
  Future<void> updateOrphanageUser(String id, OrphanageUserEditDto dto) async {
    try {
      await _adminAccountManagementService.updateOrphanageUser(id, dto);
      print('Orphanage user updated successfully');
    } catch (e) {
      print('Exception occurred while updating orphanage user: $e');
      throw Exception('Failed to update orphanage user');
    }
  }

  // 보육원 사용자 삭제
  Future<void> deleteOrphanageUser(String id) async {
    try {
      await _adminAccountManagementService.deleteOrphanageUser(id);
      print('Orphanage user deleted successfully');
    } catch (e) {
      print('Exception occurred while deleting orphanage user: $e');
      throw Exception('Failed to delete orphanage user');
    }
  }

  // 보육원 사용자 이름으로 조회
  Future<void> getOrphanageUserByName(String name) async {
    try {
      orphanageUserDetailState.loading();
      final orphanageDetail = await _adminAccountManagementService.getOrphanageUserByName(name);
      orphanageUserDetailState.success(value: orphanageDetail);
      print('Orphanage user detail loaded successfully by name: $name');
    } catch (e) {
      orphanageUserDetailState.error(message: e.toString());
      print('Exception occurred while loading orphanage user by name: $e');
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
