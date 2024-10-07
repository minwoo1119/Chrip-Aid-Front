import 'package:json_annotation/json_annotation.dart';

part 'post_thanks_entity.g.dart';

@JsonSerializable()
class PostThanksEntity {
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

  PostThanksEntity({
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photos,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });

  factory PostThanksEntity.fromJson(Map<String, dynamic> json) =>
      _$PostThanksEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostThanksEntityToJson(this);
}
