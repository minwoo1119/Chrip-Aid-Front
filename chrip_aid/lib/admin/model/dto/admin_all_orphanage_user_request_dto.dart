import 'package:json_annotation/json_annotation.dart';

part 'admin_all_orphanage_user_request_dto.g.dart';

@JsonSerializable()
class OrphanageUser {
  final String name;
  final String email;

  OrphanageUser({
    required this.name,
    required this.email,
  });

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메서드
  factory OrphanageUser.fromJson(Map<String, dynamic> json) => _$OrphanageUserFromJson(json);

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$OrphanageUserToJson(this);
}
