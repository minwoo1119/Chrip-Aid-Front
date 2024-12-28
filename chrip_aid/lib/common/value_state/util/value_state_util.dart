import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:flutter/material.dart';

extension ValueStateWithResponse<T> on ValueStateNotifier<T> {
  void withResponse(Future<ResponseEntity<T>> response) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loading();
      await response.then((value) {
        if (value.entity == null && value.message == null) {
          none();
        } else if (value.isSuccess) {
          success(value: value.entity, message: value.message);
        } else {
          error(value: value.entity, message: value.message);
        }
      });
    });
  }
}
