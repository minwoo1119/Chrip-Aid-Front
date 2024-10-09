import 'package:chrip_aid/chatting/model/entity/chat_message_entity.dart';
import 'package:chrip_aid/common/value_state/state/value_state.dart';

class ChattingMessageState extends ValueStateNotifier<List<ChatMessageEntity>> {
  ChattingMessageState() : super();

  factory ChattingMessageState.loading() {
    final state = ChattingMessageState();
    state.loading();
    return state;
  }

  factory ChattingMessageState.success({required List<ChatMessageEntity> data}) {
    final state = ChattingMessageState();
    state.success(value: data);
    return state;
  }

  factory ChattingMessageState.error({String? message}) {
    final state = ChattingMessageState();
    state.error(message: message);
    return state;
  }
}
