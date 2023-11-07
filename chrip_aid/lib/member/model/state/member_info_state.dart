import 'package:chrip_aid/common/state/state.dart';
import 'package:chrip_aid/member/model/entity/member_entity.dart';

abstract class MemberInfoState {}

class MemberInfoStateNone extends NoneState implements MemberInfoState {}

class MemberInfoStateLoading extends LoadingState implements MemberInfoState {}

class MemberInfoStateSuccess extends SuccessState<MemberEntity>
    implements MemberInfoState {
  MemberInfoStateSuccess(super.data);
}

class MemberInfoStateError extends ErrorState implements MemberInfoState {
  MemberInfoStateError(super.message);
}
