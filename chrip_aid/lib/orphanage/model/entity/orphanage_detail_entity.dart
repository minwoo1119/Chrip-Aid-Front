import 'package:json_annotation/json_annotation.dart';
import 'request_item_entity.dart';

@JsonSerializable()
class OrphanageDetailEntity {
  @JsonKey(name: 'name')
  final String name;
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
  final List<RequestItemEntity> requests;

  OrphanageDetailEntity({
    required this.orphanageName,
    required this.address,
    required this.phoneNumber,
    required this.photo,
    required this.homepageLink,
    required this.name,
    required this.description,
    required this.requests,
  });

  OrphanageDetailEntity.fromJson(Map<String, dynamic> json)
      : orphanageName = json["orphanage_name"],
        address = json["address"],
        phoneNumber = json["phone_number"],
        photo = json["photo"],
        homepageLink = json["homepage_link"],
        name = json["name"],
        description = json["description"],
        requests = (json["requests"] as List<dynamic>)
            .map((item) => RequestItemEntity.fromJson(item))
            .toList();
}
