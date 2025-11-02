import '../../data/models/response/movie_details_response.dart';
import '../../data/models/response/movies_list_response.dart';

sealed class MoviesStates {}

final class MoviesInitial extends MoviesStates {}

// GET MOVIES LIST
final class MoviesListLoading extends MoviesStates {}

final class MoviesListSuccess extends MoviesStates {
  final MoviesListResponse moviesListResponse;
  MoviesListSuccess(this.moviesListResponse);
}

final class MoviesListFailure extends MoviesStates {
  final String message;
  MoviesListFailure(this.message);
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
