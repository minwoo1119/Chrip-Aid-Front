import 'package:json_annotation/json_annotation.dart';
import 'request_item_entity.dart';

part 'orphanage_detail_entity.g.dart';

@JsonSerializable()
class OrphanageDetailEntity {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'orphanage_id')
  final int orphanageId;
  @JsonKey(name: 'orphanage_name')
  final String orphanageName;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'homepage_link')
  final String homepageLink;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'photo')
  final String photo;
  @JsonKey(name: 'requests')
  final List<RequestItemEntity>? requests;

  OrphanageDetailEntity({
    required this.orphanageId,
    required this.orphanageName,
    required this.address,
    required this.phoneNumber,
    required this.photo,
    required this.homepageLink,
    required this.name,
    required this.description,
    required this.requests,
  });

  Map<String, dynamic> toJson() => _$OrphanageDetailEntityToJson(this);

  factory OrphanageDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageDetailEntityFromJson(json);
}
