import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'core/di/dependency_injection.dart';
import 'core/theming/theme_cubit.dart';
import 'prawareness_app.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedBloc storage
 HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await setupGetIt();

  runApp(
    BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: const PrawarenessApp(),
    ),
  );
}