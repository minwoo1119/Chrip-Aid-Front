import 'package:chrip_aid/common/entity/response_entity.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_delete_dto.dart';
import 'package:chrip_aid/orphanage/model/dto/donate_request_dto.dart';
import 'package:chrip_aid/orphanage/model/entity/add_basket_item_entity.dart';
import 'package:chrip_aid/orphanage/model/entity/update_basket_item_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/orphanage_basket_entity.dart';
import '../repository/orphanage_basket_repository.dart';

final orphanageBasketServiceProvider = Provider((ref) {
  final repository = ref.watch(orphanageBasketRepositoryProvider);
  return OrphanageBasketService(repository);
});

class OrphanageBasketService {
  final OrphanageBasketRepository repository;

  OrphanageBasketService(this.repository);

  Future<ResponseEntity<List<OrphanageBasketEntity>>>
      getOrphanageBasket() async {
    try {
      final data = await repository.getOrphanageBasket();
      return ResponseEntity.success(entity: data);
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageBasketEntity>>> updateOrphanageBasket({
    required UpdateBasketItemEntity entity,
  }) async {
    try {
      await repository.updateBasket(entity);
      return getOrphanageBasket();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageBasketEntity>>> deleteOrphanageBasket(
    DonateDeleteDto dto,
  ) async {
    try {
      await repository.deleteBasket(dto);
      return getOrphanageBasket();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageBasketEntity>>> addOrphanageBasket({
    required AddBasketItemEntity entity,
  }) async {
    try {
      await repository.addBasket(entity);
      return getOrphanageBasket();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }

  Future<ResponseEntity<List<OrphanageBasketEntity>>> donate(
    DonateRequestDTO dto,
  ) async {
    try {
      await repository.donate(dto);
      return getOrphanageBasket();
    } catch (e) {
      return ResponseEntity.error(message: e.toString());
    }
  }
}
