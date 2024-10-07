import 'package:json_annotation/json_annotation.dart';

import '../entity/report_entity.dart';

part 'admin_report_dto.g.dart';

@JsonSerializable()
class AdminReportDto {
  final String reportId;
  final String description;
  final String reporterId;
  final String reporterName;
  final String reporterType;
  final String? targetId;
  final String? targetName;
  final String? targetType;
  final String? boardId;
  final String? boardTitle;
  final String? boardType;

  AdminReportDto({
    required this.reportId,
    required this.description,
    required this.reporterId,
    required this.reporterName,
    required this.reporterType,
    this.targetId,
    this.targetName,
    this.targetType,
    this.boardId,
    this.boardTitle,
    this.boardType,
  });

  // DTO -> Entity 변환 메소드
  ReportEntity toEntity() {
    return ReportEntity(
      reportId: reportId,
      description: description,
      reporterId: reporterId,
      reporterName: reporterName,
      reporterType: reporterType,
      targetId: targetId,
      targetName: targetName,
      targetType: targetType,
      boardId: boardId,
      boardTitle: boardTitle,
      boardType: boardType,
    );
  }

  // JSON 직렬화 및 역직렬화 관련 메소드도 추가할 수 있음
  factory AdminReportDto.fromJson(Map<String, dynamic> json) {
    return AdminReportDto(
      reportId: json['report_id'],
      description: json['description'],
      reporterId: json['reporter_id'],
      reporterName: json['reporter_name'],
      reporterType: json['reporter_type'],
      targetId: json['target_id'],
      targetName: json['target_name'],
      targetType: json['target_type'],
      boardId: json['board_id'],
      boardTitle: json['board_title'],
      boardType: json['board_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': reportId,
      'description': description,
      'reporter_id': reporterId,
      'reporter_name': reporterName,
      'reporter_type': reporterType,
      'target_id': targetId,
      'target_name': targetName,
      'target_type': targetType,
      'board_id': boardId,
      'board_title': boardTitle,
      'board_type': boardType,
    };
  }
}
