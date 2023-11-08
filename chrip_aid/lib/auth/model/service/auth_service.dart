import 'package:chrip_aid/auth/dto/login_request_dto.dart';
import 'package:chrip_aid/auth/dto/signup_request_dto.dart';
import 'package:chrip_aid/auth/model/repository/auth_repository.dart';
import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/common/local_storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final fcmRepository = ref.watch(fcmRepositoryProvider);
  final storage = ref.watch(localStorageProvider);
  return AuthService(authRepository, fcmRepository, storage);
});

class AuthService extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final FcmRepository fcmRepository;
  final LocalStorage storage;

  AuthService(
    this.authRepository,
    this.fcmRepository,
    this.storage,
  ) : super(AuthStateNone()) {
    saveFcmToken();
  }

  Future login({required String id, required String password}) async {
    state = AuthStateLoading();
    try {
      await authRepository.login(LoginRequestDto(id: id, password: password));
      await saveFcmToken();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return state = AuthStateError("id 또는 password가 틀렸습니다.");
      }
      if (e.response?.statusCode == 200) {
        return state = AuthStateError(e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      state = AuthStateError("서버와 연결할 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future logout() async {
    state = AuthStateLoading();
    await _removeToken();
    state = AuthStateNone();
  }

  Future saveFcmToken() async {
   try {
      final fcmToken = await fcmRepository.getFcmToken();
      await authRepository.saveToken(fcmToken);
      state = AuthStateSuccess(true);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        state = AuthStateError(
          e.response?.data["message"] ?? "알 수 없는 에러가 발생했습니다.",
        );
      }
      state = AuthStateError("서버와 통신할 수 없습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future signup(SignupRequestDto signupRequestDto) async {
    state = AuthStateLoading();
    try {
      await authRepository.signup(signupRequestDto);
      state = AuthStateNone();
    } on DioException catch (e) {
      state = AuthStateError(e.message ?? "회원가입에 실패하였습니다.");
    } catch (e) {
      state = AuthStateError("알 수 없는 에러가 발생했습니다.");
    }
  }

  Future _removeToken() async {
    Future.wait([
      storage.delete(key: dotenv.get('ACCESS_TOKEN_KEY')),
      storage.delete(key: dotenv.get('REFRESH_TOKEN_KEY')),
    ]);
  }
}
