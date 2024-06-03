import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_task/utils/http/http_client.dart';

import '../feature/todo/todo.dart';
final apiServiceProvider =
Provider<ApiService>((_) => ApiService());
class ApiService {
  Future<List<Todo>> fetchTodos(int limit, int skip) async {
    final data = await CustomHttpHelper()
        .get("dummyjson.com/todos?limit=$limit&skip=$skip");
    final todos =
        (data['todos'] as List).map((todo) => Todo.fromJson(todo)).toList();
    return todos;
  }

  Future<Map<String, dynamic>> fetchGeoJson() async {
    final data = await CustomHttpHelper().get(
        "d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_geography_regions_points.geojson");
    return data;
  }
}
