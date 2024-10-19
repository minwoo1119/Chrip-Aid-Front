import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/post/model/entity/post_request_entity.dart';
import 'package:chrip_aid/post/model/entity/post_reservation_entity.dart';
import 'package:chrip_aid/post/model/entity/post_thanks_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dto/item_request_post_dto.dart';
import '../dto/visit_request_post_dto.dart';
import '../dto/thanks_post_dto.dart';
import '../repository/admin_postmanagement_repository.dart';

final adminPostManagementServiceProvider = Provider((ref) {
  final repository = ref.read(adminPostManagementRepositoryProvider);
  return AdminPostManagementService(repository, ref);
});

class AdminPostManagementService {
  final Ref ref;
  late final AdminPostManagementRepository repository;

  AdminPostManagementService(this.repository, this.ref);

  // 방문 예약글 목록 조회
  Future<ResponseEntity<List<PostReservationEntity>>> getReservationPostList() async {
    try {
      List<VisitRequestPostDto> dtos = await repository.getReservationPosts();
      List<PostReservationEntity> data = dtos.map((dto) => dto.toEntity()).toList();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 방문 예약글 조회
  Future<ResponseEntity<PostReservationEntity>> getReservationPostById(int postId) async {
    try {
      VisitRequestPostDto dto = await repository.getReservationPostsById(postId);
      PostReservationEntity data = dto.toEntity();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 방문 예약글 삭제
  Future<ResponseEntity> deleteReservationPost(int postId) async {
    try {
      await repository.deleteReservationPost(postId);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 물품 요청글 목록 조회
  Future<ResponseEntity<List<PostRequestEntity>>> getRequestPostList() async {
    try {
      List<ItemRequestPostDto> dtos = await repository.getRequestPosts();
      List<PostRequestEntity> data = dtos.map((dto) => dto.toEntity()).toList();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 물품 요청글 조회
  Future<ResponseEntity<PostRequestEntity>> getRequestPostById(int postId) async {
    try {
      ItemRequestPostDto dto = await repository.getRequestPostsById(postId);
      PostRequestEntity data = dto.toEntity();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 물품 요청글 삭제
  Future<ResponseEntity> deleteRequestPost(int postId) async {
    try {
      await repository.deleteRequestPost(postId);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 기부 감사글 목록 조회
  Future<ResponseEntity<List<PostThanksEntity>>> getThanksPostList() async {
    try {
      List<ThanksPostDto> dtos = await repository.getThanksPosts();
      List<PostThanksEntity> data = dtos.map((dto) => dto.toEntity()).toList();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 특정 기부 감사글 조회
  Future<ResponseEntity<PostThanksEntity>> getThanksPostById(int postId) async {
    try {
      ThanksPostDto dto = await repository.getThanksPostsById(postId);
      PostThanksEntity data = dto.toEntity();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  // 기부 감사글 삭제
  Future<ResponseEntity> deleteThanksPost(int postId) async {
    try {
      await repository.deleteThanksPost(postId);
      return ResponseEntity.success();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
