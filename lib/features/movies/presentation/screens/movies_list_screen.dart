import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/my_theme.dart';
import '../../../../core/theming/theme_cubit.dart';
import '../logic/movies_cubit.dart';
import '../logic/movies_states.dart';
import '../widgets/movie_list_item.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_outlined,
              color: theme.primary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Movies',
              style: theme.headlineStyle,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.wb_sunny_outlined,
              color: theme.primary,
            ),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: _buildMoviesList(context, state, theme),
              ),
              Padding(
                padding: theme.containerPadding,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<MoviesCubit>().getMoviesList();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.secondary,
                      foregroundColor: theme.textSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: theme.cardBorderRadius,
                      ),
                    ),
                    child: Text(
                      'Load More Movies',
                      style: theme.buttonStyle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMoviesList(BuildContext context, MoviesStates state, MyTheme theme) {
    return switch (state) {
      MoviesListLoading() => Center(
          child: CircularProgressIndicator(
            color: theme.primary,
          ),
        ),
      MoviesListSuccess() => ListView.builder(
          itemCount: state.moviesListResponse.results.length,
          itemBuilder: (context, index) {
            final movie = state.moviesListResponse.results[index];
            return MovieListItem(
              title: movie.title,
              rating: movie.voteAverage,
              genre: movie.genreIds.isNotEmpty ? 'Genre: ${movie.genreIds.first}' : 'Unknown',
              posterPath: movie.posterPath,
              onTap: () {
                context.push(Routes.movieDetails, extra: movie.id);
              },
            );
          },
        ),
      MoviesListFailure() => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: theme.primary,
                size: 60,
              ),
              SizedBox(height: theme.spacing),
              Text(
                'Error: ${state.message}',
                style: theme.bodyStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: theme.spacing),
              ElevatedButton(
                onPressed: () {
                  context.read<MoviesCubit>().getMoviesList();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      _ => Center(
          child: Text(
            'No movies available',
            style: theme.bodyStyle,
          ),
        ),
    };
  }
}

