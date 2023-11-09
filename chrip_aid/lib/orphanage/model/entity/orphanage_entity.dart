class OrphanageEntity {
  final int orphanageId;
  final String orphanageName;
  final String address;
  final String phoneNumber;
  final String photo;
  final String name;

  OrphanageEntity({
    required this.orphanageId,
    required this.orphanageName,
    required this.address,
    required this.phoneNumber,
    required this.photo,
    required this.name,
  });

  OrphanageEntity.fromJson(Map<String, dynamic> json)
      : orphanageId = json["orphanage_id"],
        orphanageName = json["orphanage_name"],
        address = json["address"],
        phoneNumber = json["phone_number"],
        photo = json["photo"],
        name = json["name"];
}
