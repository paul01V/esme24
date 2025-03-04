import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/screens/home_page.dart';
import 'package:swipezone/screens/planning_page.dart';
import 'package:swipezone/screens/select_page.dart';
import 'package:swipezone/screens/map_page.dart';
import 'package:swipezone/screens/nfc_page.dart';
import 'package:swipezone/repositories/models/location.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage(
          title: 'HomePage',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'planningpage',
          builder: (BuildContext context, GoRouterState state) {
            return const PlanningPage(
              title: "PlanningPage",
            );
          },
        ),
        GoRoute(
          path: 'selectpage',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectPage(
              title: "SelectPage",
            );
          },
        ),
        GoRoute(
          path: 'nfcscan',
          builder: (BuildContext context, GoRouterState state) {
            return NFCScanPage();
          },
        ),
        GoRoute(
          path: 'mappage',
          builder: (BuildContext context, GoRouterState state) {
            List<Location> selectedLocations = state.extra as List<Location>;
            return MapPage(selectedLocations: selectedLocations);
          },
        ),
      ],
    ),
  ],
);

