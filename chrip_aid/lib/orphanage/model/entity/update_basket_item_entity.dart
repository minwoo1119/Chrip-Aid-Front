import 'package:json_annotation/json_annotation.dart';
part 'update_basket_item_entity.g.dart';

@JsonSerializable()
class UpdateBasketItemEntity {
  @JsonKey(name: 'count')
  int count;
  @JsonKey(name: 'request_id')
  int requestId;

  UpdateBasketItemEntity(this.count, this.requestId);

  Map<String, dynamic> toJson()=>  _$UpdateBasketItemEntityToJson(this);
}