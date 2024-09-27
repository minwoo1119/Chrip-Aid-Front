import 'package:chrip_aid/auth/model/service/auth_service.dart';
import 'package:chrip_aid/auth/model/state/auth_state.dart';
import 'package:chrip_aid/auth/model/state/authority_state.dart';
import 'package:chrip_aid/chatting/model/service/chatting_service.dart';
import 'package:chrip_aid/chatting/model/state/chatting_state.dart';
import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/common/value_state/util/value_state_util.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chattingViewModelProvider = Provider((ref) => ChattingViewModel(ref));

ChattingState chattingState = ChattingState();

class ChattingViewModel{
  final Ref ref;
  late final ChattingService _chattingService;

  final AuthState authState = AuthState();

  final AuthorityState authorityState = AuthorityState();

  ChattingViewModel(this.ref) {
    _chattingService = ref.read(chattingServiceProvider);
  }

  // void getInfo() => chattingState
  //    .withResponse(_chattingService.getOrphanageInfo() as Future<ResponseEntity<List<OrphanageEntity>>>);

}