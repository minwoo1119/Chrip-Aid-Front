import 'package:json_annotation/json_annotation.dart';

part 'get_posts_entity.g.dart';

@JsonSerializable()
class GetPostsEntity {
  @JsonKey(name: 'review_id')
  final int reviewId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'photos')
  final List<String> photo;
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'orphanage_name')
  final String orphanageName;
  @JsonKey(name: 'product_names')
  final List<String> productNames;

  GetPostsEntity({
    required this.reviewId,
    required this.title,
    required this.content,
    required this.photo,
    required this.date,
    required this.name,
    required this.orphanageName,
    required this.productNames,
  });

  factory GetPostsEntity.fromJson(Map<String, dynamic> json) =>
      _$GetPostsEntityFromJson(json);
}
