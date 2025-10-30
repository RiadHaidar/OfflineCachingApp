import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movies_list_response.g.dart';

@JsonSerializable()
class MoviesListResponse {
  final int page;
  final List<Movie> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  MoviesListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesListResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesListResponseToJson(this);
}
