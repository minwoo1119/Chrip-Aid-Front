import 'package:json_annotation/json_annotation.dart';
import '../../../post/model/entity/post_thanks_entity.dart';

part 'thanks_post_dto.g.dart';

@JsonSerializable()
class ThanksPostDto {
  @JsonKey(name: 'review_id')
  final int reviewId;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'content')
  final String content;

  @JsonKey(name: 'photos')
  final List<String> photos;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'orphanage_name')
  final String orphanageName;

  @JsonKey(name: 'product_names')
  final List<String> productNames;

  ThanksPostDto({
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photos,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });

  factory ThanksPostDto.fromJson(Map<String, dynamic> json) =>
      _$ThanksPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ThanksPostDtoToJson(this);

  // DTO에서 Entity로 변환
  PostThanksEntity toEntity() {
    return PostThanksEntity(
      reviewId: reviewId,
      title: title,
      content: content,
      photos: photos,
      date: date,
      name: name,
      orphanageName: orphanageName,
      productNames: productNames,
    );
  }
}
