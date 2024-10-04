import 'package:json_annotation/json_annotation.dart';

part 'orphanage_member_entity.g.dart';

@JsonSerializable()
class OrphanageMemberEntity {
  @override
  @JsonKey(name: 'orphanage_id')
  final String orphanageId;

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

  OrphanageMemberEntity({
    required this.orphanageId,
    required this.orphanageName,
    required this.address,
    required this.homepageLink,
    required this.phoneNumber,
    required this.description,
    required this.photo,
  });

  @override
  Map<String, dynamic> toJson() => _$OrphanageMemberEntityToJson(this);

  factory OrphanageMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$OrphanageMemberEntityFromJson(json);
}
