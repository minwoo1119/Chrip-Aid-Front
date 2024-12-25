import 'package:chrip_aid/chatting/model/entity/chatting_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatting_user_dto.g.dart';

@JsonSerializable()
class ChattingUserDto {
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

  ChattingUserDto({
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

  factory ChattingUserDto.fromJson(Map<String, dynamic> json) => _$ChattingUserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChattingUserDtoToJson(this);

  ChattingUserEntity toEntity() {
    return ChattingUserEntity(
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
