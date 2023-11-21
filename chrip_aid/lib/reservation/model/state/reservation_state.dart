import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/reservation/model/entity/reservation_entity.dart';

class ReservationState extends ValueStateNotifier<List<ReservationEntity>> {}
class OrphanageReservationState extends ValueStateNotifier<List<OrphanageReservationEntity>> {}
class ReservationPostState extends ValueStateNotifier {}
