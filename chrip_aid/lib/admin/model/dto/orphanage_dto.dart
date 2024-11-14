import 'package:json_annotation/json_annotation.dart';

part 'orphanage_dto.g.dart';

@JsonSerializable()
class OrphanageDto {
  @JsonKey(name: 'orphanage_id')
  final int orphanageId;

  @JsonKey(name: 'orphanage_name')
  final String orphanageName;

  @JsonKey(name: 'address')
  final String adress;

  @JsonKey(name: 'homepage_link')
  final String homepageLink;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'photo')
  final String photo;


  OrphanageDto({
    required this.orphanageId,
    required this.orphanageName,
    required this.adress,
    required this.homepageLink,
    required this.phoneNumber,
    required this.description,
    required this.photo,
  });

  factory OrphanageDto.fromJson(Map<String, dynamic> json) =>
      _$OrphanageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrphanageDtoToJson(this);
}
