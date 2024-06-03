import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/feature/map/map_provider.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'map_model.dart';

class GeoJsonMapScreen extends ConsumerStatefulWidget {
  const GeoJsonMapScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _GeoJsonMapScreenState();
}

class _GeoJsonMapScreenState extends ConsumerState<GeoJsonMapScreen> {
  late MapProvider viewModel;

  @override
  void initState() {
    // initiate view model
    viewModel = ref.read(mapProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call view model fetch data
      viewModel.fetchGeoJsonData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Users')),
        body: Consumer(builder: (context, ref, child) {
          final state = ref.watch(mapProvider);
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.collection != null) {
            CameraPosition initialCameraPosition =
                const CameraPosition(target: LatLng(27.81, 84.07), zoom: 5);

            return MaplibreMap(
              initialCameraPosition: initialCameraPosition,
              onMapCreated: onMapCreated,
            );
          }

          return const SizedBox.shrink();
        }));
  }

  Future<void> onMapCreated(MaplibreMapController controller) async {
    FeatureCollection collection = viewModel.collection!;
    controller.addGeoJsonSource(
        "geojson-source",
        GeojsonSourceProperties(
          data: collection.toJson(),
          cluster: true,
        ) as Map<String, dynamic>);

    controller.addSymbolLayer(
        "geojson-source",
        "symbol-layer",
        const SymbolLayerProperties(
            iconSize: 24,
            iconAllowOverlap: true,
            iconImage:await addImageFromAsset(
            controller, "custom-marker", "assets/symbols/custom-marker.png");));

    controller.onSymbolTapped.add((symbol) {
      symbol.id;
    });
  }
}
