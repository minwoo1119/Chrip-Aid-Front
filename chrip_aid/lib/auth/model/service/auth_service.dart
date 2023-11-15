import 'package:chrip_aid/auth/dto/login_request_dto.dart';
import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:chrip_aid/auth/model/repository/auth_repository.dart';
import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/provider/authority_provider.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final fcmRepository = ref.read(fcmRepositoryProvider);
  final storage = ref.read(localStorageProvider);
  return AuthService(authRepository, fcmRepository, storage, ref);
});

class AuthService {
  final AuthRepository authRepository;
  final FcmRepository fcmRepository;
  final LocalStorage storage;

  final Ref ref;

  AuthState authState = AuthState();

  AuthService(this.authRepository, this.fcmRepository, this.storage, this.ref) {
    saveFcmToken();
  }

  Future login({required String id, required String password}) async {
    authState.loading();
    try {
      await Future.delayed(const Duration(seconds: 3));
      await authRepository.login(
        LoginRequestDto(email: id, password: password),
      );
      await saveFcmToken();
      await saveAuthority(ref);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return authState.error(message: "id 또는 password가 틀렸습니다.");
      }
      if (e.response?.statusCode == 200) {
        return authState.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      authState.error(message: e.message ?? "서버와 연결할 수 없습니다.");
    } catch (e) {
      authState.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future logout() async {
    authState.loading();
    await _removeToken();
    authState.none();
  }

  Future saveFcmToken() async {
    try {
      final fcmToken = await fcmRepository.getFcmToken();
      await authRepository.saveToken(fcmToken);
      authState.success(value: true);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        authState.error(
          message: e.response?.data["message"] ?? "알 수 없는 에러가 발생했습니다.",
        );
      }
      authState.error(message: "서버와 통신할 수 없습니다.");
    } catch (e) {
      authState.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future signup(SignupRequestDto signupRequestDto) async {
    authState.loading();
    try {
      await authRepository.signup(signupRequestDto);
      authState.none();
    } on DioException catch (e) {
      authState.error(
        message: e.response?.data["message"] ?? "회원가입에 실패하였습니다.",
      );
    } catch (e) {
      authState.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
  }
}
