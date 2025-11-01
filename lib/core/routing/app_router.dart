import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/movies/presentation/screens/movie_details_screen.dart';
import '../../features/movies/presentation/screens/movies_list_screen.dart';
import '../theming/theme_cubit.dart';
import 'routes.dart';

class AppRouter {
  static GoRouter createRouter(ThemeCubit themeCubit) {
    return GoRouter(
      initialLocation: Routes.moviesList,
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return BlocProvider<ThemeCubit>.value(
              value: themeCubit,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: Routes.moviesList,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MoviesListScreen(),
              ),
            ),
            GoRoute(
              path: Routes.movieDetails,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MovieDetailsScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
