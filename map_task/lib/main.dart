import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:map_task/feature/todo/todo_screen.dart';
import 'package:map_task/utils/theme/custom_app_theme.dart';

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
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage()),
      GoRoute(
          path: '/todo',
          builder: (BuildContext context, GoRouterState state) =>
              const TodoScreen()),
      GoRoute(
          path: '/map',
          builder: (BuildContext context, GoRouterState state) =>
              const GeoJsonMapScreen()),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.push('/todo');
                },
                child: Text("ToDo")),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: () {
                  context.push('/map');
                },
                child: Text("Map")),
          ],
        ),
      ),
    );
  }
}
