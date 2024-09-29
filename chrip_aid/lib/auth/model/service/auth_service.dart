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
      print("로그인 요청 시작");
      // 1. Login 요청 보내기
      await authRepository.login(
        LoginRequestDto(email: id, password: password),
      );
      print("로그인 요청 성공");

      // 2. 권한 저장하기
      await saveAuthority();
      print("권한 저장 성공");

      // 3. FCM 토큰 저장
      final response = await saveFcmToken();
      print("FCM 토큰 저장 요청 성공");

      return response;
    } on DioException catch (e) {
      // HTTP 에러 처리
      print("DioException 발생: ${e.response?.statusCode}, ${e.message}");
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
      // 일반 예외 처리
      print("알 수 없는 에러 발생: $e");
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity> logout() async {
    try {
      print("로그아웃 요청 시작");
      await _removeToken();
      print("로그아웃 성공");
      return ResponseEntity.success();
    } catch (e) {
      print("로그아웃 에러 발생: $e");
      return ResponseEntity.error(message: "로그아웃에 실패하였습니다.");
    }
  }

  Future<ResponseEntity> saveFcmToken() async {
    try {
      print("FCM 토큰 저장 시작");
      // 1. 토큰이 있는지 확인
      final accessToken = await storage.read(key: dotenv.get("ACCESS_TOKEN_KEY"));
      if (accessToken == null) {
        print("액세스 토큰이 없습니다.");
        return ResponseEntity.error();
      }

      // 2. FCM 토큰 가져오기
      final fcmToken = await fcmRepository.getFcmToken();
      print("FCM 토큰: $fcmToken");

      // 3. 서버에 토큰 저장
      await authRepository.saveToken(fcmToken);
      print("FCM 토큰 서버 저장 성공");

      return ResponseEntity.success(entity: true);
    } on DioException catch (e) {
      print("DioException 발생: ${e.response?.statusCode}, ${e.message}");
      if (e.response != null && e.response!.statusCode == 400) {
        return ResponseEntity.error(
          message: e.response?.data["message"] ?? "알 수 없는 에러가 발생했습니다.",
        );
      }
      return ResponseEntity.error(message: "서버와 통신할 수 없습니다.");
    } catch (e) {
      print("알 수 없는 에러 발생: $e");
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity> signup(SignupRequestDto signupRequestDto) async {
    try {
      print("회원가입 요청 시작");
      await authRepository.signup(signupRequestDto);
      print("회원가입 성공");
      return ResponseEntity.success();
    } on DioException catch (e) {
      print("DioException 발생: ${e.response?.statusCode}, ${e.message}");
      return ResponseEntity.error(
        message: e.response?.data["message"] ?? "회원가입에 실패하였습니다.",
      );
    } catch (e) {
      print("알 수 없는 에러 발생: $e");
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    print("토큰 삭제 요청 시작");
    await Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
    print("토큰 삭제 완료");
  }
}
