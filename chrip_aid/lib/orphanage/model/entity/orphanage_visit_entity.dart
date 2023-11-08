import 'package:json_annotation/json_annotation.dart';
part 'orphanage_visit_entity.g.dart';

@JsonSerializable()
class OrphanageVisitEntity {
  @JsonKey(name: 'orphanage_id')
  final int orphanageId;
  @JsonKey(name: 'visit_date')
  final String visitDate;
  @JsonKey(name: 'reason')
  final String reason;

  OrphanageVisitEntity({
    required this.orphanageId,
    required this.visitDate,
    required this.reason
  });

  Map<String, dynamic> toJson()=>  _$OrphanageVisitEntityToJson(this);
}