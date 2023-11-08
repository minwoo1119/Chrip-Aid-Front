import 'package:json_annotation/json_annotation.dart';
part 'donate_delete_dto.g.dart';

@JsonSerializable()
class DonateDeleteDto {
  @JsonKey(name: 'basket_product_id')
  final int basketProductId;


  DonateDeleteDto({
    required this.basketProductId,
  });

  Map<String, dynamic> toJson()=>  _$DonateDeleteDtoToJson(this);
}