import 'package:json_annotation/json_annotation.dart';

import '../../../auth/model/type/region/sub_region.dart';
import '../../../auth/model/type/sex.dart';

part 'user_detail_entity.g.dart';

@JsonSerializable()
class UserDetailEntity {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'age')
  final int age;

  @JsonKey(name: 'sex', fromJson: _sexFromJson, toJson: _sexToJson)
  final Sex sex;

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'region', fromJson: _regionFromJson, toJson: _regionToJson)
  final SubRegion region;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'profile_photo')
  final String profilePhoto;

  @JsonKey(name: 'role')
  final String role;

  static Sex _sexFromJson(String sex) => Sex.fromString(sex);

  static String _sexToJson(Sex sex) => sex.value;

  static SubRegion _regionFromJson(String region) => SubRegion.fromString(region);

  static String _regionToJson(SubRegion region) => region.toJson();

  UserDetailEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.sex,
    required this.nickname,
    required this.region,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.role,
  });

  // JSON 변환 함수들
  factory UserDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailEntityToJson(this);
}
