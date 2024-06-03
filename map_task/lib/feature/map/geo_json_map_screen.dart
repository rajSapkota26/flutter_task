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
        appBar: AppBar(title: const Text('Map')),
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
                const CameraPosition(target: LatLng(0, 0), zoom: 5);
                // const CameraPosition(target: LatLng(27.81, 84.07), zoom: 5);

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
   

   Object geoJson=collection.toJson() as Object;
    // Add GeoJSON source
    controller.addSource(
        "geojson-source",
        GeojsonSourceProperties(
          data: geoJson,
          cluster: true,
        ));
    controller.addLayer(
        "geojson-source",
        "circle-layer",
        const CircleLayerProperties(
            circleColor: "#0000FF", circleRadius: 14));
    controller.addLayer(
        "geojson-source",
        "symbols-layer",
        const SymbolLayerProperties(
          iconAllowOverlap: true,
          iconImage: "assets://icon.jpeg", // Use the icon from assets
          iconSize: 15.0, // Adjust the icon size as needed
        ));

    // Listen for symbol tap events
    controller.onFeatureTapped.add((id, point, latlng) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Latitude: ${latlng.latitude}, Longitude:  ${latlng.longitude}',
            ),

          ));
      // final feature = collection.features.firstWhere(
      //         (element) => element.id == id,
      //     orElse: () => Feature());
    });
  }

}
