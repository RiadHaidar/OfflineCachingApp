// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesListResponse _$MoviesListResponseFromJson(Map<String, dynamic> json) =>
    MoviesListResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MoviesListResponseToJson(MoviesListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
