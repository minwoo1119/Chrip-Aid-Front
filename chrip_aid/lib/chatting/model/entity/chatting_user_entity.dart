import 'package:json_annotation/json_annotation.dart';

part 'chatting_user_entity.g.dart';

@JsonSerializable()
class ChattingUserEntity {
  final String userId;
  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  final String phoneNumber;
  final String profilePhoto;

  ChattingUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
  });

  factory ChattingUserEntity.fromJson(Map<String, dynamic> json) =>
      _$ChattingUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ChattingUserEntityToJson(this);
}