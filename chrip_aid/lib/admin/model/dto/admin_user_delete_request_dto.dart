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
        print('Failed to delete user: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        switch (e.response?.statusCode) {
          case 401:
            print('Unauthorized request.');
            break;
          case 404:
            print('User not found.');
            break;
          default:
            print('An unexpected error occurred: ${e.response?.statusCode} - ${e.message}');
        }
      } else {
        print('An error occurred: $e');
      }
    }
  }
}
