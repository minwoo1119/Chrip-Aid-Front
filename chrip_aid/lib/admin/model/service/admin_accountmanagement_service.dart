import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../orphanage/model/entity/orphanage_detail_entity.dart';
import '../../../orphanage/model/entity/orphanage_entity.dart';
import '../repository/admin_accountmanager_repository.dart';

final adminAccountManagementServiceProvider = Provider((ref) {
  final repository = ref.read(adminAccountManagementRepositoryProvider);
  return AdminAccountManagementService(repository);
});

class AdminAccountManagementService {
  final AdminAccountManagementRepository repository;
  AdminAccountManagementService(this.repository);

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

  Future<UserDetailEntity> getUserById(String userId) async {
    try {
      return await repository.getUserById(userId);
    } catch (e) {
      throw Exception('Failed to load user details: $e');
    }
  }

  Future<List<OrphanageUserEntity>> getOrphanageUserList() async {
    try {
      return await repository.getAllOrphanageUsers();
    } catch (e) {
      throw Exception('Failed to load orphanage user list: $e');
    }
  }

  Future<OrphanageDetailEntity> getOrphanageUserById(String orphanageUserId) async {
    try {
      return await repository.getOrphanageUserById(orphanageUserId);
    } catch (e) {
      throw Exception('Failed to load orphanage user details: $e');
    }
  }
}
