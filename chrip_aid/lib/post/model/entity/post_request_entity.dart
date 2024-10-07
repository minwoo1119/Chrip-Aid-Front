import 'package:json_annotation/json_annotation.dart';

part 'post_request_entity.g.dart';

@JsonSerializable()
class PostRequestEntity {
  @JsonKey(name: 'request_id')
  final int requestId;

  @JsonKey(name: 'count')
  final int count;

  @JsonKey(name: 'supported_count')
  final int supportedCount;

  @JsonKey(name: 'state')
  final String state;

  @JsonKey(name: 'message')
  final String message;

  PostRequestEntity({
    required this.requestId,
    required this.count,
    required this.supportedCount,
    required this.state,
    required this.message,
  });

  factory PostRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PostRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestEntityToJson(this);
}
