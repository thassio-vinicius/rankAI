import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rankai/core/presentation/routes/route_names.dart';
import 'package:rankai/features/home/presentation/home_screen.dart';
import 'package:rankai/features/splash/presentation/splash_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.splash,
  observers: [],
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const SplashScreen(),
          name: state.name,
        );
      },
    ),
    GoRoute(
      name: RouteNames.home,
      path: RouteNames.home,
      pageBuilder: (context, state) {
        return MaterialPage(
          child: const HomeScreen(),
          name: state.name,
        );
      },
    ),
  ],
);
