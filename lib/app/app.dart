import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';

/// Root widget of the app. Wires theme and router.
class LittleLightsApp extends ConsumerWidget {
  const LittleLightsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'LittleLights',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
