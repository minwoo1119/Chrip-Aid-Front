import 'package:chrip_aid/post/model/entity/write_post_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'write_post_request_dto.g.dart';

@JsonSerializable()
class WritePostRequestDTO {
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "photos")
  String photos;
  @JsonKey(name: "products")
  List<WritePostProductDTO> products;

  WritePostRequestDTO({
    required this.title,
    required this.content,
    required this.photos,
    required this.products,
  });


  Map<String, dynamic> toJson() => _$WritePostRequestDTOToJson(this);

  factory WritePostRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$WritePostRequestDTOFromJson(json);
}
