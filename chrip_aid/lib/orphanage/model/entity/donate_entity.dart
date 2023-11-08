import 'package:json_annotation/json_annotation.dart';
part 'donate_entity.g.dart';

@JsonSerializable()
class DonateEntity {
  @JsonKey(name: 'orphanage_name')
  final String orphanageName;
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'message')
  final String message;

  DonateEntity({
    required this.orphanageName,
    required this.date,
    required this.productName,
    required this.price,
    required this.count,
    required this.message,
  });

  factory DonateEntity.fromJson(Map<String, dynamic> json) =>
      _$DonateEntityFromJson(json);

}

// class OrphanageDonateEntity {
//   final String userNickname;
//   final DateTime date;
//   final String productName;
//   final int price;
//   final int count;
//   final String message;
//
//   OrphanageDonateEntity({
//     required this.userNickname,
//     required this.date,
//     required this.productName,
//     required this.price,
//     required this.count,
//     required this.message,
//   });
// }
