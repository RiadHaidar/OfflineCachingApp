import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';
import 'core/theming/colors.dart';

class PrawarenessApp extends StatelessWidget {
  const PrawarenessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PR Awareness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
