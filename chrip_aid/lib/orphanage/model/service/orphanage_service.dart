import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:chrip_aid/orphanage/model/repository/orphanage_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orphanageServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageRepositoryProvider);
  return OrphanageService(repository);
});

class OrphanageService {
  final OrphanageRepository repository;

  OrphanageService(this.repository);

  Future<ResponseEntity<List<OrphanageEntity>>> getOrphanageList() async {
    try {
      List<OrphanageEntity> data = await repository.getOrphanageList();
      return ResponseEntity.success(entity: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }

  Future<ResponseEntity<OrphanageDetailEntity>> getOrphanageDetail(int orphanageId) async {
    try {
      final data = await repository.getOrphanageDetail(orphanageId);
      return ResponseEntity.success(entity: data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 200) {
        return ResponseEntity.error(message: e.message ?? "알 수 없는 에러가 발생했습니다.");
      }
      return ResponseEntity.error(message: "서버와 연결할 수 없습니다.");
    } catch (e) {
      return ResponseEntity.error(message: "알 수 없는 에러가 발생했습니다.");
    }
  }
}
