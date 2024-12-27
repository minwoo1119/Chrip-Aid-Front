import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../post/model/entity/post_request_entity.dart';
import '../../../post/model/entity/post_reservation_entity.dart';
import '../../../post/model/entity/post_thanks_entity.dart';
import '../service/admin_postmanagement_service.dart';

// 상태 클래스
class PostManagementState {
  final List<PostReservationEntity>? reservationPosts;
  final List<PostRequestEntity>? requestPosts;
  final List<PostThanksEntity>? thanksPosts;
  final bool isLoading;
  final String? errorMessage;

  PostManagementState({
    this.reservationPosts,
    this.requestPosts,
    this.thanksPosts,
    this.isLoading = false,
    this.errorMessage,
  });

  PostManagementState copyWith({
    List<PostReservationEntity>? reservationPosts,
    List<PostRequestEntity>? requestPosts,
    List<PostThanksEntity>? thanksPosts,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PostManagementState(
      reservationPosts: reservationPosts ?? this.reservationPosts,
      requestPosts: requestPosts ?? this.requestPosts,
      thanksPosts: thanksPosts ?? this.thanksPosts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Notifier 클래스
class PostManagementNotifier extends StateNotifier<PostManagementState> {
  final AdminPostManagementService _service;

  PostManagementNotifier(this._service) : super(PostManagementState(isLoading: true));

  // 게시글 데이터 초기 로드
  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final reservationPosts = await _service.getReservationPostList();
      final requestPosts = await _service.getRequestPostList();
      final thanksPosts = await _service.getThanksPostList();

      state = state.copyWith(
        reservationPosts: reservationPosts.entity,
        requestPosts: requestPosts.entity,
        thanksPosts: thanksPosts.entity,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      print('게시글 로드 중 오류 발생: $e');
    }
  }

  // 방문 예약글 삭제
  Future<void> deleteReservationPost(int id) async {
    try {
      await _service.deleteReservationPost(id);
      final updatedList = state.reservationPosts
          ?.where((post) => post.reservationId != id)
          .toList();
      state = state.copyWith(reservationPosts: updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      print('방문 예약글 삭제 중 오류 발생: $e');
    }
  }

  // 물품 요청글 삭제
  Future<void> deleteRequestPost(int id) async {
    try {
      await _service.deleteRequestPost(id);
      final updatedList = state.requestPosts
          ?.where((post) => post.requestId != id)
          .toList();
      state = state.copyWith(requestPosts: updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      print('물품 요청글 삭제 중 오류 발생: $e');
    }
  }

  // 기부 감사글 삭제
  Future<void> deleteThanksPost(int id) async {
    try {
      await _service.deleteThanksPost(id);
      final updatedList = state.thanksPosts
          ?.where((post) => post.reviewId != id)
          .toList();
      state = state.copyWith(thanksPosts: updatedList);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      print('기부 감사글 삭제 중 오류 발생: $e');
    }
  }

  // 방문 예약글 추가
  Future<void> addReservationPost(PostReservationEntity post) async {
    final updatedList = List<PostReservationEntity>.from(state.reservationPosts ?? []);
    updatedList.add(post);
    state = state.copyWith(reservationPosts: updatedList);
  }
}

// Provider 추가
final postManagementProvider =
StateNotifierProvider<PostManagementNotifier, PostManagementState>(
      (ref) {
    final service = ref.read(adminPostManagementServiceProvider);
    return PostManagementNotifier(service);
  },
);
