import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/movies_repo.dart';
import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  final MoviesRepo _repo;

  MoviesCubit(this._repo) : super(MoviesInitial());

  // ====== GET MOVIES LIST ======
  Future<void> getMoviesList({
    bool includeAdult = false,
    bool includeVideo = false,
    String language = 'en-US',
    int page = 1,
    String sortBy = 'popularity.desc',
  }) async {
    emit(MoviesListLoading());
    final result = await _repo.getMovies(
      includeAdult: includeAdult,
      includeVideo: includeVideo,
      language: language,
      page: page,
      sortBy: sortBy,
    );
    result.when(
      success: (data) => emit(MoviesListSuccess(data)),
      failure: (error) => emit(MoviesListFailure(error)),
    );
  }

  // ====== GET MOVIE DETAILS ======
  Future<void> getMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());
    final result = await _repo.getMovieDetails(movieId);
    result.when(
      success: (data) => emit(MovieDetailsSuccess(data)),
      failure: (error) => emit(MovieDetailsFailure(error)),
    );
  }
}
