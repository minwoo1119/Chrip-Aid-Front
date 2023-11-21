import 'package:chrip_aid/common/value_state/state/value_state.dart';
import 'package:chrip_aid/management/model/entity/product_request_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';

class OrphanageProductListState extends ValueStateNotifier<List<ProductEntity>> {}
class ProductRequestState extends ValueStateNotifier<ProductRequestEntity> {}
