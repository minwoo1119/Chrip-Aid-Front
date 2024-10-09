import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/chatting/model/entity/chat_room_entity.dart';

class ChattingRoomState extends ValueStateNotifier<List<ChatRoomEntity>> {
  ChattingRoomState() : super();

  factory ChattingRoomState.loading() {
    final state = ChattingRoomState();
    state.loading();
    return state;
  }

  factory ChattingRoomState.success({required List<ChatRoomEntity> data}) {
    final state = ChattingRoomState();
    state.success(value: data);
    return state;
  }

  factory ChattingRoomState.error({String? message}) {
    final state = ChattingRoomState();
    state.error(message: message);
    return state;
  }
}
