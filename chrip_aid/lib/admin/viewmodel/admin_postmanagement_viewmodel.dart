import 'package:chrip_aid/orphanage/model/state/orphanage_detail_state.dart';
import 'package:chrip_aid/post/model/entity/post_request_entity.dart';
import 'package:chrip_aid/post/model/entity/post_reservation_entity.dart';
import 'package:chrip_aid/post/model/entity/post_thanks_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/service/admin_postmanagement_service.dart';
import '../../common/value_state/state/value_state.dart';

final adminPostManagementViewModelProvider =
Provider((ref) => AdminPostmanagementViewmodel(ref));

class AdminPostmanagementViewmodel {
  Ref ref;
  late final AdminPostManagementService _adminPostManagementService;

  // 상태 관리 객체
  ValueStateNotifier<List<PostReservationEntity>> reservationPostsState = ValueStateNotifier();
  ValueStateNotifier<List<PostRequestEntity>> requestPostsState = ValueStateNotifier();
  ValueStateNotifier<List<PostThanksEntity>> thanksPostsState = ValueStateNotifier();

  OrphanageDetailState orphanageState = OrphanageDetailState();

  AdminPostmanagementViewmodel(this.ref) {
    _adminPostManagementService = ref.read(adminPostManagementServiceProvider);
  }

  // 방문 예약글 가져오기
  Future<void> getReservationPosts() async {
    try {
      reservationPostsState.loading();
      print('Loading reservation posts...');

      // 서비스 호출 및 ResponseEntity 확인
      final response = await _adminPostManagementService.getReservationPostList();

      if (response.isSuccess) {
        // 성공 상태라면 실제 데이터 추출
        final List<PostReservationEntity>? posts = response.entity;
        if (posts != null) {
          reservationPostsState.success(value: posts);
          print('Reservation posts successfully loaded: $posts');
        } else {
          throw Exception('No posts available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      reservationPostsState.error(message: e.toString());
      print('Exception occurred while loading reservation posts: $e');
    }
  }

  // 방문 예약글 ID로 조회하기
  Future<void> getReservationPostById(int id) async {
    try {
      reservationPostsState.loading();
      print('Loading reservation post with ID: $id');

      // 서비스 호출 및 ResponseEntity 확인
      final response = await _adminPostManagementService.getReservationPostById(id);

      if (response.isSuccess) {
        final PostReservationEntity? post = response.entity;
        if (post != null) {
          reservationPostsState.success(value: [post]);
          print('Reservation post successfully loaded: $post');
        } else {
          throw Exception('No post available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      reservationPostsState.error(message: e.toString());
      print('Exception occurred while loading reservation post by ID: $e');
    }
  }

// 방문 예약글 삭제하기
  Future<void> deleteReservationPost(int id) async {
    try {
      print('Deleting reservation post with ID: $id');

      // 서비스 호출 및 ResponseEntity 확인
      final response = await _adminPostManagementService.deleteReservationPost(id);

      if (response.isSuccess) {
        print('Reservation post successfully deleted');
        // 필요 시 삭제 후 상태 업데이트
        await getReservationPosts();
      } else {
        throw Exception(response.message ?? 'Failed to delete the post');
      }
    } catch (e) {
      print('Exception occurred while deleting reservation post: $e');
    }
  }

  // 물품 요청글 가져오기
  Future<void> getRequestPosts() async {
    try {
      requestPostsState.loading();
      print('Loading request posts...');

      // 서비스 호출 및 ResponseEntity 확인
      final response = await _adminPostManagementService.getRequestPostList();

      if (response.isSuccess) {
        // 성공 상태라면 실제 데이터 추출
        final List<PostRequestEntity>? posts = response.entity;
        if (posts != null) {
          requestPostsState.success(value: posts);
          print('Request posts successfully loaded: $posts');
        } else {
          throw Exception('No posts available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      requestPostsState.error(message: e.toString());
      print('Exception occurred while loading request posts: $e');
    }
  }

  // 물품 요청글 ID로 조회하기
  Future<void> getRequestPostById(int id) async {
    try {
      requestPostsState.loading();
      print('Loading request post with ID: $id');

      final response = await _adminPostManagementService.getRequestPostById(id);

      if (response.isSuccess) {
        final PostRequestEntity? post = response.entity;
        if (post != null) {
          requestPostsState.success(value: [post]);
          print('Request post successfully loaded: $post');
        } else {
          throw Exception('No post available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      requestPostsState.error(message: e.toString());
      print('Exception occurred while loading request post by ID: $e');
    }
  }

// 물품 요청글 삭제하기
  Future<void> deleteRequestPost(int id) async {
    try {
      print('Deleting request post with ID: $id');

      final response = await _adminPostManagementService.deleteRequestPost(id);

      if (response.isSuccess) {
        print('Request post successfully deleted');
        await getRequestPosts();
      } else {
        throw Exception(response.message ?? 'Failed to delete the post');
      }
    } catch (e) {
      print('Exception occurred while deleting request post: $e');
    }
  }

  // 기부 감사글 가져오기
  Future<void> getThanksPosts() async {
    try {
      thanksPostsState.loading();
      print('Loading thanks posts...');

      // 서비스 호출 및 ResponseEntity 확인
      final response = await _adminPostManagementService.getThanksPostList();

      if (response.isSuccess) {
        // 성공 상태라면 실제 데이터 추출
        final List<PostThanksEntity>? posts = response.entity;
        if (posts != null) {
          thanksPostsState.success(value: posts);
          print('Thanks posts successfully loaded: $posts');
        } else {
          throw Exception('No posts available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      thanksPostsState.error(message: e.toString());
      print('Exception occurred while loading thanks posts: $e');
    }
  }

  // 기부 감사글 ID로 조회하기
  Future<void> getThanksPostById(int id) async {
    try {
      thanksPostsState.loading();
      print('Loading thanks post with ID: $id');

      final response = await _adminPostManagementService.getThanksPostById(id);

      if (response.isSuccess) {
        final PostThanksEntity? post = response.entity;
        if (post != null) {
          thanksPostsState.success(value: [post]);
          print('Thanks post successfully loaded: $post');
        } else {
          throw Exception('No post available');
        }
      } else {
        throw Exception(response.message ?? 'Unknown error occurred');
      }
    } catch (e) {
      thanksPostsState.error(message: e.toString());
      print('Exception occurred while loading thanks post by ID: $e');
    }
  }

// 기부 감사글 삭제하기
  Future<void> deleteThanksPost(int id) async {
    try {
      print('Deleting thanks post with ID: $id');

      final response = await _adminPostManagementService.deleteThanksPost(id);

      if (response.isSuccess) {
        print('Thanks post successfully deleted');
        await getThanksPosts();
      } else {
        throw Exception(response.message ?? 'Failed to delete the post');
      }
    } catch (e) {
      print('Exception occurred while deleting thanks post: $e');
    }
  }
}

