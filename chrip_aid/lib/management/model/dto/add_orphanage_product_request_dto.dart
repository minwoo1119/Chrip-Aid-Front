import 'package:json_annotation/json_annotation.dart';

part 'add_orphanage_product_request_dto.g.dart';

@JsonSerializable()
class AddOrphanageProductRequestDTO {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "message")
  String message;

  AddOrphanageProductRequestDTO({
    required this.title,
    required this.count,
    required this.message,
  });


  Map<String, dynamic> toJson() => _$AddOrphanageProductRequestDTOToJson(this);

  factory AddOrphanageProductRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$AddOrphanageProductRequestDTOFromJson(json);
}
