import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.moviesList,
    routes: [
      GoRoute(
        path: Routes.moviesList,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Scaffold(
            body: Center(
              child: Text('Movies List - Coming Soon'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: Routes.movieDetails,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Scaffold(
            body: Center(
              child: Text('Movie Details - Coming Soon'),
            ),
          ),
        ),
      ),
    ],
  );
}
