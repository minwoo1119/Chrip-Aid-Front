import 'package:chrip_aid/member/model/entity/orphanage_member_entity.dart';
import 'package:chrip_aid/member/model/entity/user_detail_entity.dart';

abstract class MemberEntity {
  final String email;
  final String name;

  MemberEntity({
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson();

  factory MemberEntity.fromJson(Map<String, dynamic> json) {
    if (json["orphanage_id"] == null) {
      // UserDetailEntity를 MemberEntity로 명시적 캐스팅
      return UserDetailEntity.fromJson(json) as MemberEntity;
    } else {
      // OrphanageMemberEntity를 MemberEntity로 명시적 캐스팅
      return OrphanageMemberEntity.fromJson(json) as MemberEntity;
    }
  }
}