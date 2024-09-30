import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio;

  UserRepository({required this.dio});

  Future<void> deleteUser({required String id, required String accessToken}) async {
    try {
      final response = await dio.delete(
        '/admin/users/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('User successfully deleted.');
      } else {
        print('Failed to delete user.');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print('Unauthorized request.');
        } else if (e.response?.statusCode == 404) {
          print('User not found.');
        } else {
          print('An unexpected error occurred: ${e.message}');
        }
      } else {
        print('An error occurred: $e');
      }
    }
  }
}
