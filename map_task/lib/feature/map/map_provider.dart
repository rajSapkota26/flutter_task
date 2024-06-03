import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/feature/map/map_model.dart';

import '../../network/api_service.dart';
import '../../utils/custom_exception/http_response_exception.dart';

final mapProvider = ChangeNotifierProvider<MapProvider>((ref) {
  return MapProvider(ref.read(apiServiceProvider));
});

class MapProvider extends ChangeNotifier {
  final ApiService apiService;

  MapProvider(this.apiService);

  bool isLoading = false;
  String error = '';
  FeatureCollection? collection;

  Future<void> fetchGeoJsonData() async {
    try {
      isLoading = true;
      var geoJson = await apiService.fetchGeoJson();
      collection = FeatureCollection.fromJson(geoJson);
      if (collection != null) {
        isLoading = false;
        notifyListeners();
      }
    } on SessionExpiredException {
      error = "SessionExpiredException";
      //session expired
    } on CustomException {
      //custom defined exception
      error = "CustomException";
    } catch (e) {
      //exception
      error = "$e";
    }
  }
}
