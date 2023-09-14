import 'package:chrip_aid/auth/util/google_map_util.dart';
import 'package:chrip_aid/orphanage/viewmodel/orphanage_search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrphanageSearchScreen extends ConsumerStatefulWidget {
  const OrphanageSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrphanageSearchScreen> createState() =>
      _OrphanageSearchScreenState();
}

class _OrphanageSearchScreenState extends ConsumerState<OrphanageSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(orphanageSearchViewModelProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.getPlaceByName("경기도 파주시 법원읍 술이홀로 907번길 139우)10826"),
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) => viewModel.mapController = controller,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        markers: viewModel.markers,
      ),
    );
  }
}
