import 'package:json_annotation/json_annotation.dart';
import '../entity/chat_room_entity.dart';

part 'chat_room_dto.g.dart';

@JsonSerializable()
class ChatRoomDto {
  @JsonKey(name: 'chat_room_id') // 서버 응답의 chat_room_id와 매핑
  final String chatRoomId;

  @JsonKey(name: 'user') // 중첩된 객체도 같은 방식으로 처리
  final UserDto user;

  @JsonKey(name: 'orphanage_user')
  final OrphanageUserDto orphanageUser;

  ChatRoomDto({
    required this.chatRoomId,
    required this.user,
    required this.orphanageUser,
  });

  // JSON 직렬화 및 역직렬화 메소드
  factory ChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomDtoToJson(this);

  // 엔티티 변환 메소드
  ChatRoomEntity toEntity() {
    return ChatRoomEntity(
      chatRoomId: chatRoomId,
      user: user.toEntity(),
      orphanageUser: orphanageUser.toEntity(),
    );
  }
}

@JsonSerializable()
class UserDto {
  @JsonKey(name: 'user_id') // 서버에서 user_id를 userId로 매핑
  final String userId;

  final String name;
  final String email;
  final int age;
  final String sex;
  final String nickname;
  final String region;
  @JsonKey(name: 'phone_number') // 서버에서 phone_number를 phoneNumber로 매핑
  final String phoneNumber;

  @JsonKey(name: 'profile_photo') // 서버에서 profile_photo를 profilePhoto로 매핑
  final String profilePhoto;

  UserDto({
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

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      name: name,
      email: email,
      age: age,
      sex: sex,
      nickname: nickname,
      region: region,
      phoneNumber: phoneNumber,
      profilePhoto: profilePhoto,
    );
  }
}

@JsonSerializable()
class OrphanageUserDto {
  @JsonKey(name: 'orphanage_user_id') // 서버에서 orphanage_user_id를 orphanageUserId로 매핑
  final String orphanageUserId;

  final String name;
  final String email;

  OrphanageUserDto({
    required this.orphanageUserId,
    required this.name,
    required this.email,
  });

  factory OrphanageUserDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OrphanageUserDtoToJson(this);

  OrphanageUserEntity toEntity() {
    return OrphanageUserEntity(
      orphanageUserId: orphanageUserId,
      name: name,
      email: email,
    );
  }
}
