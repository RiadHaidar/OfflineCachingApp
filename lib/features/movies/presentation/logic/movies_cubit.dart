import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/pagination_manager.dart';
import '../../data/models/response/movie.dart';
import '../../data/repos/movies_repo.dart';
import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  final MoviesRepo _repo;
  final _pagination = PaginationManager<Movie>();

  MoviesCubit(this._repo) : super(MoviesInitial());

  // ====== GET MOVIES LIST ======
  Future<void> getMoviesList({
    bool includeAdult = false,
    bool includeVideo = false,
    String language = 'en-US',
    String sortBy = 'popularity.desc',
  }) async {
    emit(MoviesListLoading());
    _pagination.reset();

    final result = await _repo.getMovies(
      includeAdult: includeAdult,
      includeVideo: includeVideo,
      language: language,
      page: 1,
      sortBy: sortBy,
    );

    result.when(
      success: (data) {
        _pagination.updateWithNewPage(
          data: data.results,
          page: data.page,
          total: data.totalPages,
          isRefresh: true,
        );
        emit(MoviesListSuccess(
          movies: _pagination.items,
          hasMore: _pagination.hasMore,
        ));
      },
      failure: (error) => emit(MoviesListFailure(message: error)),
    );
  }

  // ====== LOAD MORE MOVIES ======
  Future<void> loadMore({
    bool includeAdult = false,
    bool includeVideo = false,
    String language = 'en-US',
    String sortBy = 'popularity.desc',
  }) async {
    if (!_pagination.canLoadMore) return;

    _pagination.isLoadingMore = true;
    emit(MoviesListLoadingMore(
      movies: _pagination.items,
      hasMore: _pagination.hasMore,
    ));

    final result = await _repo.getMovies(
      includeAdult: includeAdult,
      includeVideo: includeVideo,
      language: language,
      page: _pagination.currentPage + 1,
      sortBy: sortBy,
    );

    result.when(
      success: (data) {
        _pagination.updateWithNewPage(
          data: data.results,
          page: data.page,
          total: data.totalPages,
        );
        emit(MoviesListSuccess(
          movies: _pagination.items,
          hasMore: _pagination.hasMore,
        ));
      },
      failure: (error) {
        _pagination.isLoadingMore = false;
        emit(MoviesListFailure(
          message: error,
          movies: _pagination.items,
        ));
      },
    );
  }

  // ====== REFRESH MOVIES ======
  Future<void> refresh({
    bool includeAdult = false,
    bool includeVideo = false,
    String language = 'en-US',
    String sortBy = 'popularity.desc',
  }) async {
    _pagination.reset();

    final result = await _repo.getMovies(
      includeAdult: includeAdult,
      includeVideo: includeVideo,
      language: language,
      page: 1,
      sortBy: sortBy,
    );

    result.when(
      success: (data) {
        _pagination.updateWithNewPage(
          data: data.results,
          page: data.page,
          total: data.totalPages,
          isRefresh: true,
        );
        emit(MoviesListSuccess(
          movies: _pagination.items,
          hasMore: _pagination.hasMore,
        ));
      },
      failure: (error) => emit(MoviesListFailure(message: error)),
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
