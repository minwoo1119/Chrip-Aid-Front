import 'package:chrip_aid/auth/model/type/region/sub_region.dart';
import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_detail_entity.g.dart';

@JsonSerializable()
class UserDetailEntity implements MemberEntity {
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'nickname')
  final String nickName;
  @JsonKey(name: 'age')
  final int age;
  @JsonKey(name: 'sex', fromJson: _sexFromJson, toJson: _sexToJson)
  final Sex sex;
  @JsonKey(
    name: 'region',
    fromJson: _regionFromJson,
    toJson: _regionToJson,
  )
  final SubRegion region;
  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'profile_photo')
  final String profileUrl;
  @JsonKey(name: 'role')
  final String role;

  static Sex _sexFromJson(String sex) => Sex.fromString(sex);

  static String _sexToJson(Sex sex) => sex.value;

  static SubRegion _regionFromJson(String region) =>
      SubRegion.fromString(region);

  static String _regionToJson(SubRegion region) => region.toJson();

  UserDetailEntity({
    required this.email,
    required this.name,
    required this.nickName,
    required this.age,
    required this.sex,
    required this.region,
    required this.phone,
    required this.profileUrl,
    required this.role,
  });

  @override
  Map<String, dynamic> toJson() => _$UserDetailEntityToJson(this);

  factory UserDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDetailEntityFromJson(json);
}
