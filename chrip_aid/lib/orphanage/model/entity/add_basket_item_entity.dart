import 'package:json_annotation/json_annotation.dart';
part 'add_basket_item_entity.g.dart';

@JsonSerializable()
class AddBasketItemEntity {
  @JsonKey(name: 'count')
  final int requestId;
  @JsonKey(name: 'request_id')
  final int count;

  AddBasketItemEntity({
    required this.requestId,
    required this.count,
  });

  Map<String, dynamic> toJson()=>  _$AddBasketItemEntityToJson(this);
}