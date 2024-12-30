import 'package:chrip_aid/admin/view/admin_screen.dart';
import 'package:chrip_aid/auth/dto/login_request_dto.dart';
import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:chrip_aid/auth/model/repository/auth_repository.dart';
import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';
import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';
import 'package:chrip_aid/member/model/repository/member_info_repository.dart';
import 'package:chrip_aid/user/model/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../member/model/entity/member_entity.dart';
import '../../../member/model/entity/orphanage_user_entity.dart';
import '../../../user/model/repository/user_repository.dart';

final authServiceProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final memberInfoRepository = ref.read(memberInfoRepositoryProvider);
  final fcmRepository = ref.read(fcmRepositoryProvider);
  final storage = ref.read(localStorageProvider);
  return AuthService(authRepository, userRepository, memberInfoRepository, fcmRepository, storage);
});

class AuthService {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final MemberInfoRepository memberInfoRepository;
  final FcmRepository fcmRepository;
  final LocalStorage storage;

  AuthService(this.authRepository, this.userRepository, this.memberInfoRepository, this.fcmRepository, this.storage);

  Future<ResponseEntity> login({
    required String id,
    required String password,
    required BuildContext context,
    required bool isOrphanage
  }) async {
    try {
      print("로그인 요청 시작");

      // 1. Login 요청 보내기
      await authRepository.login(LoginRequestDto(email: id, password: password));
      final authority = AuthorityState().value;

      print("로그인 요청 성공");

      // 2. 권한 확인 후 사용자 상세 정보 요청
      dynamic userDetail;

      if (authority == AuthorityType.user) {
        print("Authority: 사용자(user)");
        userDetail = await getUserDetailInfo(); // 보육원 사용자 상세 정보 요청
      } else if (authority == AuthorityType.orphanage) {
        print("Authority: 보육원(orphanage)");
        userDetail = await getMemberInfo(); // 사용자 상세 정보 요청
      } else {
        throw Exception("알 수 없는 권한 유형: $authority");
      }

      // 3. 사용자 권한 설정 및 저장
      await handleAuthority(userDetail);

      // 4. 권한에 따라 페이지 이동
      if (authority == AuthorityType.admin) {
        print("관리자 페이지로 이동");
      } else if (authority == AuthorityType.user) {
        print("일반 사용자 페이지로 이동");
        // 사용자 페이지로 이동 로직 추가 가능
      } else if (authority == AuthorityType.orphanage) {
        print("보육원 페이지로 이동");
        // 보육원 사용자 페이지로 이동 로직 추가 가능
      }

      return ResponseEntity.success(entity: userDetail);
    } on DioException catch (e) {
      // HTTP 에러 처리
      return _handleDioException(e);
    } catch (e) {
      // 일반 예외 처리
      print("알 수 없는 에러 발생: $e");
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  // 사용자 상세 정보 요청 메서드
  Future<UserDto> getUserDetailInfo() async {
    try {
      print("사용자 상세 정보 요청 시작");

      final accessToken = await storage.read(key: dotenv.get("ACCESS_TOKEN_KEY"));
      if (accessToken == null) {
        throw Exception("액세스 토큰이 없습니다.");
      }

      final userDetail = await userRepository.getUserInfo("Bearer $accessToken");
      print("사용자 상세 정보 요청 성공");
      return userDetail;
    } catch (e) {
      print("사용자 상세 정보 요청 중 에러 발생: $e");
      rethrow;
    }
  }

  // 사용자 혹은 보육원 유저 정보 요청 메서드
  Future<ResponseEntity<MemberEntity>> getMemberInfo() async {
    try {
      final data = await memberInfoRepository.getUserInfo();
      return ResponseEntity.success(entity: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "사용자 정보를 가져올 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }


  // 권한 설정 및 저장
  Future<void> setAuthority(dynamic data) async {
    if (data is UserDto) {
      if (data.role == 'user') {
        AuthorityState().success(value: AuthorityType.user);
      } else if (data.role == 'admin') {
        AuthorityState().success(value: AuthorityType.admin);
      }
    }
    else if (data is ResponseEntity<MemberEntity>) {
      final memberEntity = data.entity; // 엔티티 추출
      print("ResponseEntity<MemberEntity> 내용: $memberEntity");
      AuthorityState().success(value: AuthorityType.orphanage);
    } else {
      print(data);
      throw Exception("알 수 없는 Authority 타입입니다.");
    }

    // Authority 저장
    await saveAuthority();
    print("Authority 설정 및 저장 완료: ${AuthorityState().value}");
  }

  // Authority 핸들링 메서드
  Future<void> handleAuthority(dynamic data) async {
    try {
      await setAuthority(data);
    } catch (e) {
      print("Authority 설정 중 에러 발생: $e");
    }
  }

  // 에러 핸들링 분리
  ResponseEntity _handleDioException(DioException e) {
    print("DioException 발생: ${e.response?.statusCode}, ${e.message}");
    if (e.response?.statusCode == 404) {
      return ResponseEntity.error(message: "존재하지 않는 사용자입니다.");
    }
    if (e.response?.statusCode == 422) {
      return ResponseEntity.error(message: "비밀번호가 틀렸습니다.");
    }
    if (e.response?.statusCode == 200) {
      return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
    }
    return ResponseEntity.error(message: e.message ?? "서버와 연결할 수 없습니다.");
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

  Future _removeToken() async {
    print("토큰 삭제 요청 시작");
    await Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
      storage.delete(key: 'authority'), // authority 항목 삭제 추가
      storage.delete(key: 'FlutterSecureStorage'),
      storage.delete(key: 'FlutterSecureStorage.orphanageId'),
    ]);
    print("토큰 삭제 완료");
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
}