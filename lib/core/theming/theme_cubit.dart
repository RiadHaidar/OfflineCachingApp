import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  bool get isDarkMode => state == ThemeMode.dark;

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool? ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'isDark': state == ThemeMode.dark};
  }
}