import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../network/api_service.dart';

final geoJsonProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ApiService().fetchGeoJson();
});

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    final geoJsonAsyncValue = watch.watch(geoJsonProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: geoJsonAsyncValue.when(
        data: (geoJson) {
          return MaplibreMap(
            initialCameraPosition:
                const CameraPosition(target: LatLng(27.81, 0), zoom: 5),
            onMapCreated: (MaplibreMapController controller) {

              controller.addListener((){

              });
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
                      circleColor: "#000000", circleRadius: 24));
              controller.addLayer("geojson-source", "symbol-layer",
                  const SymbolLayerProperties(iconSize: 10));



              controller.onFeatureTapped.add((
                dynamic id,
                point,
                latLng,
              ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Latitude: ${latLng.latitude}, Longitude:  ${latLng.longitude}',
                    ),
                  ),
                );

                log("Location tapped id${point.toString()}");
                log("Location tapped point ${point.x}${point.y}");
                log("Location tapped latLng ${latLng.longitude} ${latLng.latitude}");
                // log("Location tappedgeometry ${geometry.longitude} ${geometry.latitude}");
                log("Location tapped");
              });
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stack) =>
            Center(child: Text('Error: $error')),
      ),
    );
  }
}
