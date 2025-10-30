import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../apis/movies_api_service.dart';
import '../models/response/movie_details_response.dart';
import '../models/response/movies_list_response.dart';

class MoviesRepo {
  final MoviesApiService _apiService;

  MoviesRepo(this._apiService);

  // ====== GET MOVIES LIST ======
  Future<ApiResult<MoviesListResponse>> getMovies({
    bool includeAdult = false,
    bool includeVideo = false,
    String language = 'en-US',
    int page = 1,
    String sortBy = 'popularity.desc',
  }) async {
    try {
      final result = await _apiService.getMovies(
        includeAdult: includeAdult,
        includeVideo: includeVideo,
        language: language,
        page: page,
        sortBy: sortBy,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // ====== GET MOVIE DETAILS ======
  Future<ApiResult<MovieDetailsResponse>> getMovieDetails(int id) async {
    try {
      final result = await _apiService.getMovieDetails(id: id);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
