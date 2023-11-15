import 'package:chrip_aid/common/state/data_state.dart';
import 'package:chrip_aid/orphanage/model/entity/donate_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_basket_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_detail_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/orphanage_entity.dart';

class OrphanageListState extends DataState<List<OrphanageEntity>> {}

class OrphanageDetailState extends DataState<OrphanageDetailEntity> {}

class OrphanageBasketState extends DataState<List<OrphanageBasketEntity>> {}

class OrphanageDonateState extends DataState<List<DonateEntity>> {}