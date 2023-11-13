import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  @JsonKey(name: "product_id")
  int id;
  @JsonKey(name: "product_name")
  String productName;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "product_photo")
  String image;

  ProductEntity({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
  });


  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$ProductEntityFromJson(json);
  }
}
