import 'package:chrip_aid/member/model/entity/member_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orphanage_user_entity.g.dart';

@JsonSerializable()
class OrphanageUserEntity implements MemberEntity {
  @JsonKey(name: 'orphanage_user_id')
  final String orphanageUserId;

  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'orphanage_id')
  final OrphanageId orphanageId;

  OrphanageUserEntity({
    required this.orphanageUserId,
    required this.name,
    required this.email,
    required this.orphanageId,
  });

  factory OrphanageUserEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageUserEntityToJson(this);
}

@JsonSerializable()
class OrphanageId {
  @JsonKey(name: 'orphanage_id')
  final int orphanageId;

  OrphanageId({required this.orphanageId});

  factory OrphanageId.fromJson(Map<String, dynamic> json) =>
      _$OrphanageIdFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageIdToJson(this);
}
