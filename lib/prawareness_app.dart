import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prawareness/core/theming/my_theme.dart';
import 'package:prawareness/core/theming/theme_cubit.dart';
import 'core/routing/app_router.dart';

class PrawarenessApp extends StatelessWidget {
  const PrawarenessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: 'PR Awareness',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            extensions: [lightAppTheme],
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            extensions: [darkAppTheme],
          ),
          themeMode: themeMode,
          routerConfig: AppRouter.createRouter(context.read<ThemeCubit>()),
        );
      },
    );
  }
}
