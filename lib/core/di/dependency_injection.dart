import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/movies/data/apis/movies_api_service.dart';
import '../../features/movies/data/repos/movies_repo.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ====== CORE SERVICES ======

  // Dio - Singleton
  getIt.registerLazySingleton<Dio>(
    () => DioFactory.getDio(),
  );

  // ====== FEATURE SERVICES ======

  // Movies Feature
  // Movies API Service - Singleton
  getIt.registerLazySingleton<MoviesApiService>(
    () => MoviesApiService(getIt<Dio>()),
  );

  // Movies Repository - Singleton
  getIt.registerLazySingleton<MoviesRepo>(
    () => MoviesRepo(getIt<MoviesApiService>()),
  );
}
