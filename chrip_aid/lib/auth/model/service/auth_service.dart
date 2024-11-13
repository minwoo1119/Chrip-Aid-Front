import 'package:chrip_aid/admin/view/admin_screen.dart';
import 'package:chrip_aid/auth/dto/login_request_dto.dart';
import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:chrip_aid/auth/model/repository/auth_repository.dart';
import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../user/model/repository/user_repository.dart';
import '../state/authority_state.dart';

final userProvider = StateProvider<UserDto?>((ref) => null);

final authServiceProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final fcmRepository = ref.read(fcmRepositoryProvider);
  final storage = ref.read(localStorageProvider);
  return AuthService(
    authRepository: authRepository,
    userRepository: userRepository,
    fcmRepository: fcmRepository,
    storage: storage,
    ref: ref,
  );
});

class AuthService {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final FcmRepository fcmRepository;
  final LocalStorage storage;
  final Ref ref;

  AuthService({
    required this.authRepository,
    required this.userRepository,
    required this.fcmRepository,
    required this.storage,
    required this.ref,
  });

  Future<ResponseEntity> login({
    required String id,
    required String password,
    required BuildContext context,
  }) async {
    try {
      print("로그인 요청 시작");
      await authRepository.login(
        LoginRequestDto(email: id, password: password),
      );
      print("로그인 요청 성공");

      await saveAuthority();
      print("권한 저장 성공");

      final response = await saveFcmToken();
      print("FCM 토큰 저장 요청 성공");

      final authority = await storage.read(key: 'authority');
      if (authority != 'orphanages') {
        final userDetail = await getUserDetailInfo();
        print("사용자 상세 정보 요청 성공: ${userDetail.toString()}");

        // Provider에 사용자 정보를 저장
        ref.read(userProvider.notifier).state = userDetail;

        if (userDetail.role == "admin") {
          print("관리자 페이지로 이동");
          navigateToAdminPage(context);
        } else {
          print("일반 사용자 페이지로 이동");
        }
        return ResponseEntity.success(entity: userDetail);
      } else {
        print("사용자가 orphanages 권한을 가짐 - 상세 정보 요청 없이 페이지 이동");
        return ResponseEntity.success();
      }
    } on DioException catch (e) {
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
      print("알 수 없는 에러 발생: $e");
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<UserDto> getUserDetailInfo() async {
    try {
      print("사용자 상세 정보 요청 시작");
      final accessToken = await storage.read(key: dotenv.get("ACCESS_TOKEN_KEY"));
      if (accessToken == null) {
        throw Exception("액세스 토큰이 없습니다.");
      }

      final userDetail = await userRepository.getUserInfo("Bearer $accessToken");
      print("사용자 상세 정보 요청 성공");
      print("role : ${userDetail.role}");
      return userDetail;
    } catch (e) {
      print("사용자 상세 정보 요청 중 에러 발생: $e");
      rethrow;
    }
  }

  Future<ResponseEntity> logout() async {
    try {
      print("로그아웃 요청 시작");
      await _removeToken();
      print("로그아웃 성공");
      ref.read(userProvider.notifier).state = null; // 로그아웃 시 사용자 정보 초기화
      return ResponseEntity.success();
    } catch (e) {
      print("로그아웃 에러 발생: $e");
      return ResponseEntity.error(message: "로그아웃에 실패하였습니다.");
    }
  }

  Future<void> _removeToken() async {
    print("토큰 삭제 요청 시작");
    await Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
      storage.delete(key: 'authority'),
    ]);
    print("토큰 삭제 완료");
  }

  Future<ResponseEntity> saveFcmToken() async {
    try {
      print("FCM 토큰 저장 시작");
      final accessToken = await storage.read(key: dotenv.get("ACCESS_TOKEN_KEY"));
      if (accessToken == null) {
        print("액세스 토큰이 없습니다.");
        return ResponseEntity.error(message: "Access token is missing.");
      }

      final fcmToken = await fcmRepository.getFcmToken();
      print("FCM 토큰: $fcmToken");

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

  void navigateToAdminPage(BuildContext context) {
    context.pushNamed(AdminScreen.routeName);
  }
}
