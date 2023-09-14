import 'request_item_entity.dart';

class OrphanageDetailEntity {
  final String orphanageName;
  final String address;
  final String phoneNumber;
  final String photo;
  final String homepageLink;
  final String name;
  final String description;
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
        requests = json["requests"];
}
