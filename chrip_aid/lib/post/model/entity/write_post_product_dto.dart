import 'package:json_annotation/json_annotation.dart';

part 'write_post_product_dto.g.dart';

@JsonSerializable()
class WritePostProductDTO {
  @JsonKey(name: "product_name")
  String productName;

  WritePostProductDTO({required this.productName});

  Map<String, dynamic> toJson() => _$WritePostProductDTOToJson(this);

  factory WritePostProductDTO.fromJson(Map<String, dynamic> json) =>
      _$WritePostProductDTOFromJson(json);
}
