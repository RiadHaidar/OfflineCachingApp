import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/my_theme.dart';
import '../logic/movies_cubit.dart';
import '../logic/movies_states.dart';
import '../widgets/genre_chip.dart';
import '../widgets/movie_poster.dart';
import '../widgets/rating_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {


  @override
  void initState() {
    super.initState();
    context.read<MoviesCubit>().getMovieDetails(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<MyTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Movie Details',
          style: theme.headlineStyle,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          return _buildMovieDetails(context, state, theme);
        },
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, MoviesStates state, MyTheme theme) {
    return switch (state) {
      MovieDetailsLoading() => Center(
          child: CircularProgressIndicator(
            color: theme.primary,
          ),
        ),
      MovieDetailsSuccess() => SingleChildScrollView(
          child: Padding(
            padding: theme.containerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: MoviePoster(
                    posterPath: state.movieDetails.posterPath,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.9,
                    borderRadius: 16,
                  ),
                ),
                SizedBox(height: theme.spacing * 1.5),
                Text(
                  state.movieDetails.title,
                  style: theme.headlineStyle.copyWith(fontSize: 28),
                ),
                SizedBox(height: theme.spacing),
                Row(
                  children: [
                    RatingWidget(rating: state.movieDetails.voteAverage),
                    SizedBox(width: theme.spacing),
                    if (state.movieDetails.genres.isNotEmpty)
                      GenreChip(genre: state.movieDetails.genres.first.name),
                  ],
                ),
                SizedBox(height: theme.spacing * 2),
                Text(
                  'Description',
                  style: theme.headlineStyle.copyWith(fontSize: 20),
                ),
                SizedBox(height: theme.spacing * 0.75),
                Text(
                  state.movieDetails.overview,
                  style: theme.bodyStyle.copyWith(height: 1.5),
                ),
                SizedBox(height: theme.spacing * 2),
                if (state.movieDetails.releaseDate.isNotEmpty) ...[
                  Text(
                    'Release Date',
                    style: theme.headlineStyle.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: theme.spacing * 0.5),
                  Text(
                    state.movieDetails.releaseDate,
                    style: theme.bodyStyle,
                  ),
                  SizedBox(height: theme.spacing),
                ],
                if (state.movieDetails.runtime != null) ...[
                  Text(
                    'Runtime',
                    style: theme.headlineStyle.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: theme.spacing * 0.5),
                  Text(
                    '${state.movieDetails.runtime} minutes',
                    style: theme.bodyStyle,
                  ),
                ],
              ],
            ),
          ),
        ),
      MovieDetailsFailure() => Center(
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
                  Navigator.of(context).pop();
                },
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      _ => Center(
          child: Text(
            'No movie details available',
            style: theme.bodyStyle,
          ),
        ),
    };
  }
}

