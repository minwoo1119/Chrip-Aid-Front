import 'package:dio/dio.dart';

import '../dto/admin_orphanage_user_update_request_dto.dart';

class UserRepository {
  final Dio dio;

  UserRepository({required this.dio});

  Future<void> updateOrphanageUser({
    required String id,
    required OrphanageUserUpdateRequestDto updateRequestDto,
    required String accessToken,
  }) async {
    try {
      final response = await dio.patch(
        '/admin/orphanage-users/$id',
        data: updateRequestDto.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Orphanage user successfully updated.');
      } else {
        print('Failed to update orphanage user.');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print('Unauthorized request.');
        } else if (e.response?.statusCode == 409) {
          print('Conflict: Email already exists.');
        } else {
          print('An unexpected error occurred: ${e.message}');
        }
      } else {
        print('An error occurred: $e');
      }
    }
  }
}
