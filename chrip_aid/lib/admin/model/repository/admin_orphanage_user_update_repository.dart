import 'package:chrip_aid/admin/model/dto/orphanage_user_edit_dto.dart';
import 'package:dio/dio.dart';


class AdminOrphanageUserUpdateRepository {
  final Dio dio;

  AdminOrphanageUserUpdateRepository({required this.dio});

  Future<void> updateOrphanageUser({
    required String id,
    required OrphanageUserEditDto updateRequestDto,
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
