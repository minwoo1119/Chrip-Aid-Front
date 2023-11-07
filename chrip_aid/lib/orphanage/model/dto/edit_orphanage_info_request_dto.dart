import 'package:json_annotation/json_annotation.dart';

part 'edit_orphanage_info_request_dto.g.dart';

@JsonSerializable()
class EditOrphanageInfoRequestDTO {
  @JsonKey(name: "orphanage_id")
  final int orphanageId;
  @JsonKey(name: "orphanage_name")
  final String orphanageName;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "homepage_link")
  final String homepageLink;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "photo")
  final String photo;

  EditOrphanageInfoRequestDTO({
    required this.orphanageId,
    required this.orphanageName,
    required this.address,
    required this.homepageLink,
    required this.description,
    required this.photo,
    required this.phoneNumber,
  });


  Map<String, dynamic> toJson() => _$EditOrphanageInfoRequestDTOToJson(this);

  factory EditOrphanageInfoRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$EditOrphanageInfoRequestDTOFromJson(json);
}
