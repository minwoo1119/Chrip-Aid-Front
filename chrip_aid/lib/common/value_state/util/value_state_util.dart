import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/value_state/state/value_state.dart';

extension ValueStateWithResponse<T> on ValueStateNotifier<T> {
  void withResponse(Future<ResponseEntity<T>> response) {
    loading();
    response.then((value) {
      if(value.isSuccess) {
        success(value: value.entity);
      } else {
        error(message: value.message);
      }
    });
  }
}