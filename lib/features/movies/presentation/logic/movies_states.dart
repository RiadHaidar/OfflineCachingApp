import '../../data/models/response/movie.dart';
import '../../data/models/response/movie_details_response.dart';
import '../../data/models/response/movies_list_response.dart';

sealed class MoviesStates {}

final class MoviesInitial extends MoviesStates {}

// GET MOVIES LIST
final class MoviesListLoading extends MoviesStates {}

final class MoviesListSuccess extends MoviesStates {
  final List<Movie> movies;
  final bool hasMore;
  MoviesListSuccess({required this.movies, required this.hasMore});
}

final class MoviesListLoadingMore extends MoviesStates {
  final List<Movie> movies;
  final bool hasMore;
  MoviesListLoadingMore({required this.movies, required this.hasMore});
}

final class MoviesListFailure extends MoviesStates {
  final String message;
  final List<Movie> movies;
  MoviesListFailure({required this.message, this.movies = const []});
}

// GET MOVIE DETAILS
final class MovieDetailsLoading extends MoviesStates {}

final class MovieDetailsSuccess extends MoviesStates {
  final MovieDetailsResponse movieDetails;
  MovieDetailsSuccess(this.movieDetails);
}

final class MovieDetailsFailure extends MoviesStates {
  final String message;
  MovieDetailsFailure(this.message);
}
