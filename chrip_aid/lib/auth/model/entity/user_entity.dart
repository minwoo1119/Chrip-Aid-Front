import 'package:chrip_aid/auth/model/type/sex.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'age')
  final int age;
  @JsonKey(name: 'sex', fromJson: _sexFromString, toJson: _sexToString)
  final Sex sex;
  @JsonKey(name: 'region')
  final String region;
  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'profile_photo')
  final String profileUrl;

  static Sex _sexFromString(String sex) => Sex.fromString(sex);
  static String _sexToString(Sex sex) => sex.value;

  UserEntity({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.sex,
    required this.region,
    required this.phone,
    required this.profileUrl,
  });

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
