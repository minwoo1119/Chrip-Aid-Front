import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orphanage_member_entity.g.dart';

@JsonSerializable()
class OrphanageMemberEntity {
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'orphanage')
  OrphanageDetailEntity orphanage;

  OrphanageMemberEntity({
    required this.email,
    required this.name,
    required this.orphanage,
  });

  Map<String, dynamic> toJson() => _$OrphanageMemberEntityToJson(this);

  factory OrphanageMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageMemberEntityFromJson(json);
}
