import 'package:chrip_aid/common/utils/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alarm_entity.g.dart';

@JsonSerializable()
class AlarmEntity {
  final String title;
  final String body;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime time;
  @JsonKey(fromJson: _alarmTypeFromJson, toJson: _alarmTypeToJson)
  final AlarmType type;
  @JsonKey(fromJson: _infoFromJson, toJson: _infoToJson)
  final int? info;

  static DateTime _dateFromJson(String date) => alarmDateFormat.parse(date);

  static String _dateToJson(DateTime date) => alarmDateFormat.format(date);

  static AlarmType _alarmTypeFromJson(String type) => AlarmType.fromJson(type);

  static String _alarmTypeToJson(AlarmType type) => type.toJson();

  static int? _infoFromJson(String? info) => info == null ? null : int.parse(info);

  static String? _infoToJson(int? info) => info?.toString();

  AlarmEntity({
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.info,
  });

  Map<String, dynamic> toJson() => _$AlarmEntityToJson(this);

  factory AlarmEntity.fromJson(Map<String, dynamic> json) =>
      _$AlarmEntityFromJson(json);
}

enum AlarmType {
  post("POST"),
  reservation("RESERVATION");

  final String name;

  const AlarmType(this.name);

  static AlarmType fromJson(String type) =>
      AlarmType.values.firstWhere((element) => element.name == type);

  String toJson() => name;
}