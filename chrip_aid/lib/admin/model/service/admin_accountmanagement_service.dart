import 'package:chrip_aid/admin/model/dto/orphanage_user_edit_dto.dart';
import 'package:chrip_aid/admin/model/dto/user_edit_dto.dart';
import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../orphanage/model/entity/orphanage_detail_entity.dart';
import '../dto/orphanage_user_add_dto.dart';
import '../repository/admin_accountmanager_repository.dart';

final adminAccountManagementServiceProvider = Provider((ref) {
  final repository = ref.read(adminAccountManagementRepositoryProvider);
  return AdminAccountManagementService(repository);
});

class AdminAccountManagementService {
  final AdminAccountManagementRepository repository;

  AdminAccountManagementService(this.repository);

  // 사용자 정보 추가
  Future<void> createUser(UserDto dto) async {
    try {
      await repository.createUser(dto);
      print('Successfully created user');
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  // 사용자 정보 조회
  Future<List<UserDetailEntity>> getUserList() async {
    try {
      print('Requesting user list from repository...');
      List<UserDetailEntity> userList = await repository.getAllUsers();
      return userList;
    } catch (e) {
      print('Error while requesting user list: $e');
      throw Exception('Failed to load user list');
    }
  }

  // 사용자 ID로 조회
  Future<UserDetailEntity> getUserById(String userId) async {
    try {
      return await repository.getUserById(userId);
    } catch (e) {
      throw Exception('Failed to load user details: $e');
    }
  }

  // 사용자 닉네임으로 조회
  Future<UserDetailEntity> getUserByNickname(String nickname) async {
    try {
      return await repository.getUserByNickname(nickname);
    } catch (e) {
      throw Exception('Failed to load user details by nickname: $e');
    }
  }

  // 사용자 정보 수정
  Future<void> updateUser(String id, UserEditDto dto) async {
    try {
      await repository.updateUser(id, dto);
      print('Successfully updated user with id: $id');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // 사용자 정보 삭제
  Future<void> deleteUser(String id) async {
    try {
      await repository.deleteUser(id);
      print('Successfully deleted user with id: $id');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // 보육원 사용자 정보 추가
  Future<void> createOrphanageUser(OrphanageUserAddDto dto) async {
    try {
      await repository.createOrphanageUser(dto);
      print('Successfully created orphanage user');
    } catch (e) {
      throw Exception('Failed to create orphanage user: $e');
    }
  }

  // 보육원 사용자 정보 전체 조회
  Future<List<OrphanageUserEntity>> getOrphanageUserList() async {
    try {
      return await repository.getAllOrphanageUsers();
    } catch (e) {
      throw Exception('Failed to load orphanage user list: $e');
    }
  }

  // 보육원 사용자 ID로 조회
  Future<OrphanageDetailEntity> getOrphanageUserById(String orphanageUserId) async {
    try {
      return await repository.getOrphanageUserById(orphanageUserId);
    } catch (e) {
      throw Exception('Failed to load orphanage user details: $e');
    }
  }

  // 보육원 사용자 이름으로 조회
  Future<OrphanageDetailEntity> getOrphanageUserByName(String name) async {
    try {
      return await repository.getOrphanageUserByName(name);
    } catch (e) {
      throw Exception('Failed to load orphanage user by name: $e');
    }
  }

  // 보육원 사용자 정보 업데이트
  Future<void> updateOrphanageUser(String id, OrphanageUserEditDto dto) async {
    try {
      await repository.updateOrphanageUser(id, dto);
      print('Successfully updated orphanage user with id: $id');
    } catch (e) {
      throw Exception('Failed to update orphanage user: $e');
    }
  }

  // 보육원 사용자 정보 삭제
  Future<void> deleteOrphanageUser(String id) async {
    try {
      await repository.deleteOrphanageUser(id);
      print('Successfully deleted orphanage user with id: $id');
    } catch (e) {
      throw Exception('Failed to delete orphanage user: $e');
    }
  }
}
