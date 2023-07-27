import 'package:dio/dio.dart';
import 'package:chrip_aid/auth/model/entity/user_entity.dart';
import 'package:chrip_aid/common/dio/dio.dart';
import 'package:chrip_aid/auth/model/entity/login_response_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<LoginResponseEntity> login(String id, String password) async {
    return LoginResponseEntity(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  Future logout() async {}

  Future<UserEntity> getUserInfo() async {
    return UserEntity();
  }
}
