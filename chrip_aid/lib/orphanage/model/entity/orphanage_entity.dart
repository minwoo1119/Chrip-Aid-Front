import 'package:json_annotation/json_annotation.dart';

part 'orphanage_entity.g.dart';

@JsonSerializable()
class OrphanageEntity {
  @JsonKey(name: "orphanage_id")
  final int orphanageId;
  @JsonKey(name: "orphanage_name")
  final String orphanageName;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @JsonKey(name: "photo")
  final String photo;
  @JsonKey(name: "name")
  final String? name;

  OrphanageEntity({
    required this.orphanageId,
    required this.orphanageName,
    required this.address,
    required this.phoneNumber,
    required this.photo,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$OrphanageEntityToJson(this);

  factory OrphanageEntity.fromJson(Map<String, dynamic> json) {
    print("[Chrip Aid] ${json.toString()}");
    return _$OrphanageEntityFromJson(json);
  }
}
