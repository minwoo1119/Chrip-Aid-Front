import 'package:json_annotation/json_annotation.dart';
import '../../../post/model/entity/post_request_entity.dart';

part 'item_request_post_dto.g.dart';

@JsonSerializable()
class ItemRequestPostDto {
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

  ItemRequestPostDto({
    required this.requestId,
    required this.count,
    required this.supportedCount,
    required this.state,
    required this.message,
  });

  factory ItemRequestPostDto.fromJson(Map<String, dynamic> json) =>
      _$ItemRequestPostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ItemRequestPostDtoToJson(this);

  // DTO에서 Entity로 변환
  PostRequestEntity toEntity() {
    return PostRequestEntity(
      requestId: requestId,
      count: count,
      supportedCount: supportedCount,
      state: state,
      message: message,
    );
  }
}
