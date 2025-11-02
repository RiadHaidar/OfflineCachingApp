import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/movies/data/apis/movies_api_service.dart';
import '../../features/movies/data/repos/movies_repo.dart';
import '../../features/movies/presentation/logic/movies_cubit.dart';
import '../networking/dio_factory.dart';
import '../theming/my_theme.dart';
import '../theming/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ====== CORE SERVICES ======

  // Dio - Singleton
  getIt.registerLazySingleton<Dio>(
    () => DioFactory.getDio(),
  );

  // Theme Cubit - Singleton
  getIt.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(),
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

  // Movies Cubit - Factory (new instance each time)
  getIt.registerFactory<MoviesCubit>(
    () => MoviesCubit(getIt<MoviesRepo>()),
  );
}
