import 'package:json_annotation/json_annotation.dart';

part 'donate_request_dto.g.dart';

@JsonSerializable()
class DonateRequestDTO {
  @JsonKey(name: 'basket_product_id')
  final List<int> basketProductIds;
  @JsonKey(name: 'message')
  final String message;

  DonateRequestDTO({
    required this.basketProductIds,
    required this.message,
  });

  Map<String, dynamic> toJson() => _$DonateRequestDTOToJson(this);

  factory DonateRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$DonateRequestDTOFromJson(json);
}
