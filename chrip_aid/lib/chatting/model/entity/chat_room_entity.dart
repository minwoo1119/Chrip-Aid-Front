import 'package:json_annotation/json_annotation.dart';

part 'chat_room_entity.g.dart';

@JsonSerializable()
class ChatRoomEntity {
  final String chatRoomId;
  final UserEntity user; // 사용자 정보
  final OrphanageUserEntity orphanageUser; // 보육원 사용자 정보

  ChatRoomEntity({
    required this.chatRoomId,
    required this.user,
    required this.orphanageUser,
  });

  // JSON 직렬화 및 역직렬화 메소드 추가
  factory ChatRoomEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomEntityToJson(this);
}

@JsonSerializable()
class UserEntity {
  final String userId;
  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  final String phoneNumber;
  final String profilePhoto;

  UserEntity({
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

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

@JsonSerializable()
class OrphanageUserEntity {
  final String orphanageUserId;
  final String name;
  final String email;

  OrphanageUserEntity({
    required this.orphanageUserId,
    required this.name,
    required this.email,
  });

  factory OrphanageUserEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$OrphanageUserEntityToJson(this);
}
