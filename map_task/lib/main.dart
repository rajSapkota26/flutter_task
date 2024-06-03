import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:map_task/feature/todo/todo_screen.dart';

import 'feature/map/geo_json_map_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => TodoScreen()),
      GoRoute(
          path: '/map',
          builder: (BuildContext context, GoRouterState state) => GeoJsonMapScreen()),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
