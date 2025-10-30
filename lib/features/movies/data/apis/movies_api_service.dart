import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/helpers/api_constants.dart';
import '../models/response/movie_details_response.dart';
import '../models/response/movies_list_response.dart';

part 'movies_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class MoviesApiService {
  factory MoviesApiService(Dio dio) = _MoviesApiService;

  @GET(MoviesApiConstants.discoverMovies)
  Future<MoviesListResponse> getMovies({
    @Query('include_adult') bool includeAdult = false,
    @Query('include_video') bool includeVideo = false,
    @Query('language') String language = 'en-US',
    @Query('page') int page = 1,
    @Query('sort_by') String sortBy = 'popularity.desc',
  });

  @GET('/movie/{id}')
  Future<MovieDetailsResponse> getMovieDetails({
    @Path('id') required int id,
    @Query('language') String language = 'en-US',
  });
}
