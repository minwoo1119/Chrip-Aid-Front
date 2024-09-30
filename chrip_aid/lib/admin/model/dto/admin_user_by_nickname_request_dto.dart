import 'package:json_annotation/json_annotation.dart';

part 'admin_user_by_nickname_request_dto.g.dart';

@JsonSerializable()
class UserRequestDto {
  final String nickname;

  UserRequestDto({required this.nickname});

  // JSON 데이터를 Dart 객체로 변환하는 팩토리 메서드
  factory UserRequestDto.fromJson(Map<String, dynamic> json) => _$UserRequestDtoFromJson(json);

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$UserRequestDtoToJson(this);
}
