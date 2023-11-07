import 'package:json_annotation/json_annotation.dart';

part 'orphanage_product_add_request_dto.g.dart';

@JsonSerializable()
class OrphanageProductAddRequestDTO {
  @JsonKey(name: "product_name")
  String productName;
  @JsonKey(name: "count")
  int count;
  @JsonKey(name: "message")
  String message;

  OrphanageProductAddRequestDTO({
    required this.productName,
    required this.count,
    required this.message,
  });


  Map<String, dynamic> toJson() => _$OrphanageProductAddRequestDTOToJson(this);

  factory OrphanageProductAddRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$OrphanageProductAddRequestDTOFromJson(json);
}
