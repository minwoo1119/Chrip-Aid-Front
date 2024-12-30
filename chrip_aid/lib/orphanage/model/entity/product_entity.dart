import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

@JsonSerializable()
class ProductEntity {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "price")
  String price;
  @JsonKey(name: "image")
  String image;
  @JsonKey(name: "link")
  String link;

  ProductEntity({
    required this.title,
    required this.price,
    required this.image,
    required this.link,
  });


  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    print(json);
    return _$ProductEntityFromJson(json);
  }
}
