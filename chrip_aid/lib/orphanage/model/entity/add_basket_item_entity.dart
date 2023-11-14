import 'package:json_annotation/json_annotation.dart';
part 'add_basket_item_entity.g.dart';

@JsonSerializable()
class AddBasketItemEntity {
  @JsonKey(name: 'request_id')
  final int requestId;
  @JsonKey(name: 'count')
  final int count;

  AddBasketItemEntity({
    required this.requestId,
    required this.count,
  });

  Map<String, dynamic> toJson()=>  _$AddBasketItemEntityToJson(this);
}