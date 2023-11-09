// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmEntity _$AlarmEntityFromJson(Map<String, dynamic> json) => AlarmEntity(
      title: json['title'] as String,
      body: json['body'] as String,
      time: AlarmEntity._dateFromJson(json['time'] as String),
      type: AlarmEntity._alarmTypeFromJson(json['type'] as String),
      info: AlarmEntity._infoFromJson(json['info'] as String?),
    );

Map<String, dynamic> _$AlarmEntityToJson(AlarmEntity instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'time': AlarmEntity._dateToJson(instance.time),
      'type': AlarmEntity._alarmTypeToJson(instance.type),
      'info': AlarmEntity._infoToJson(instance.info),
    };
