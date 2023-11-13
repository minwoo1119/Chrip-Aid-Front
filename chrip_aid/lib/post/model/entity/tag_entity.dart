import 'package:json_annotation/json_annotation.dart';

part 'tag_entity.g.dart';

@JsonSerializable()
class TagEntity {
  @JsonKey(name: "product_name")
  final String name;
  @JsonKey(name: "is_selected")
  bool isSelected;

  TagEntity(this.name, {this.isSelected = false});

  Map<String, dynamic> toJson() => _$TagEntityToJson(this);

  factory TagEntity.fromJson(Map<String, dynamic> json) =>
      _$TagEntityFromJson(json);
}
