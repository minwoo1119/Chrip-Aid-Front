import 'package:chrip_aid/member/model/entity/orphanage_user_entity.dart';
import 'package:chrip_aid/member/model/entity/user_entity.dart';

abstract class MemberEntity {
  final String email;
  final String name;
  final OrphanageId? orphanageId; // orphanage일 경우에만 존재

  MemberEntity({
    required this.email,
    required this.name,
    this.orphanageId
  });

  Map<String, dynamic> toJson();

  factory MemberEntity.fromJson(Map<String, dynamic> json) {
    // TODO : MemberEntity factory need dependency with authority type
    if(json["orphanage_id"] == null) {
      return UserEntity.fromJson(json);
    } else {
      return OrphanageUserEntity.fromJson(json);
    }
  }
}