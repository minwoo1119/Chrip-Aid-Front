import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_member_entity.g.dart';

@JsonSerializable()
class UserMemberEntity implements MemberEntity {
  @override
  @JsonKey(name: 'email')
  String email;
  @override
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'orphanage_id')
  int userId;
  final OrphanageId? orphanageId;

  UserMemberEntity({
    required this.email,
    required this.name,
    required this.userId,
    this.orphanageId,
  });

  @override
  Map<String, dynamic> toJson() => _$UserMemberEntityToJson(this);

  factory UserMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$UserMemberEntityFromJson(json);
}
