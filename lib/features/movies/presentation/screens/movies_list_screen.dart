import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/my_theme.dart';
import '../../../../core/theming/theme_cubit.dart';
import '../logic/movies_cubit.dart';
import '../logic/movies_states.dart';
import '../widgets/movie_list_item.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<MoviesCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll * 0.9;
  }

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
          return RefreshIndicator(
            onRefresh: () => context.read<MoviesCubit>().refresh(),
            child: _buildMoviesList(context, state, theme),
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
      MoviesListSuccess() => _buildMoviesListView(
          context: context,
          movies: state.movies,
          hasMore: state.hasMore,
          isLoadingMore: false,
          theme: theme,
        ),
      MoviesListLoadingMore() => _buildMoviesListView(
          context: context,
          movies: state.movies,
          hasMore: state.hasMore,
          isLoadingMore: true,
          theme: theme,
        ),
      MoviesListFailure() => state.movies.isEmpty
          ? Center(
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
            )
          : _buildMoviesListView(
              context: context,
              movies: state.movies,
              hasMore: false,
              isLoadingMore: false,
              theme: theme,
              errorMessage: state.message,
            ),
      _ => Center(
          child: Text(
            'No movies available',
            style: theme.bodyStyle,
          ),
        ),
    };
  }

  Widget _buildMoviesListView({
    required BuildContext context,
    required List movies,
    required bool hasMore,
    required bool isLoadingMore,
    required MyTheme theme,
    String? errorMessage,
  }) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: movies.length + (isLoadingMore || errorMessage != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          if (errorMessage != null) {
            return Padding(
              padding: theme.containerPadding,
              child: Column(
                children: [
                  Text(
                    'Error: $errorMessage',
                    style: theme.bodyStyle.copyWith(color: theme.primary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: theme.spacing),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoviesCubit>().loadMore();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: CircularProgressIndicator(
                color: theme.primary,
              ),
            ),
          );
        }

        final movie = movies[index];
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
    );
  }
}

