import 'package:chrip_aid/auth/dto/login_request_dto.dart';
import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:chrip_aid/auth/model/repository/auth_repository.dart';
import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';
import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final fcmRepository = ref.read(fcmRepositoryProvider);
  final storage = ref.read(localStorageProvider);
  return AuthService(authRepository, fcmRepository, storage);
});

class AuthService {
  final AuthRepository authRepository;
  final FcmRepository fcmRepository;
  final LocalStorage storage;

  AuthService(this.authRepository, this.fcmRepository, this.storage);

  Future<ResponseEntity> login(
      {required String id, required String password}) async {
    try {
      await authRepository.login(
        LoginRequestDto(email: id, password: password),
      );
      await saveAuthority();
      return await saveFcmToken();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return ResponseEntity.error(message: "존재하지 않는 사용자 입니다.");
      }
      if (e.response?.statusCode == 422) {
        return ResponseEntity.error(message: "비밀번호가 틀렸습니다.");
      }
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: e.message ?? "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity> logout() async {
    try {
      await _removeToken();
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: "로그아웃에 실패하였습니다.");
    }
  }

  Future<ResponseEntity> saveFcmToken() async {
    try {
      if (await storage.read(key: dotenv.get("ACCESS_TOKEN_KEY")) == null) {
        return ResponseEntity.error();
      }
      final fcmToken = await fcmRepository.getFcmToken();
      await authRepository.saveToken(fcmToken);
      return ResponseEntity.success(entity: true);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        return ResponseEntity.error(
          message: e.response?.data["message"] ?? "알 수 없는 에러가 발생했습니다.",
        );
      }
      return ResponseEntity.error(message: "서버와 통신할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity> signup(SignupRequestDto signupRequestDto) async {
    try {
      await authRepository.signup(signupRequestDto);
      return ResponseEntity.success();
    } on DioException catch (e) {
      return ResponseEntity.error(
        message: e.response?.data["message"] ?? "회원가입에 실패하였습니다.",
      );
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
  }
}
