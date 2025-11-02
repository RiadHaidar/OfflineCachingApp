import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/movies/presentation/logic/movies_cubit.dart';
import '../../features/movies/presentation/screens/movie_details_screen.dart';
import '../../features/movies/presentation/screens/movies_list_screen.dart';
import '../di/dependency_injection.dart';
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
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider(
                  create: (context) => getIt<MoviesCubit>()..getMoviesList(),
                  child: const MoviesListScreen(),
                ),
              ),
            ),
            GoRoute(
              path: Routes.movieDetails,
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider.value(
                  value: getIt<MoviesCubit>(),
                  child:  MovieDetailsScreen(movieId: state.extra as int,)
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
