import 'package:chrip_aid/orphanage/model/entity/request_item_entity.dart';

class OrphanageCheckProductEntity {
  final RequestItemEntity product;
  final int count;

  OrphanageCheckProductEntity({
    required this.product,
    required this.count,
  });
}