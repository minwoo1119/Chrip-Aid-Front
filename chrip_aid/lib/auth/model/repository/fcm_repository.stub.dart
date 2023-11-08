import 'package:chrip_aid/auth/model/repository/fcm_repository.dart';

class FcmRepositoryStub implements FcmRepository{
  @override
  Future<String> getFcmToken() async => "";
}