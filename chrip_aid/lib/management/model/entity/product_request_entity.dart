import 'package:chrip_aid/orphanage/model/entity/product_entity.dart';

class ProductRequestEntity {
  final ProductEntity product;
  int count;

  ProductRequestEntity(this.product, {this.count = 1});
}
