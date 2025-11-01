import 'package:flutter/material.dart';
import 'package:prawareness/core/theming/text_styles.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'my_theme.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {

  const MyTheme({required this.background,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.headlineStyle,
    required this.bodyStyle,
    required this.captionStyle,
    required this.buttonStyle,
    required this.cardBorderRadius,
    required this.cardElevation,
    required this.spacing,
    required this.containerPadding,
  
  
  });
  final Color background;
  // Colors
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;

  // Typography
  final TextStyle headlineStyle;
  final TextStyle bodyStyle;
  final TextStyle captionStyle;
  final TextStyle buttonStyle;

  // Shapes & Dimensions
  final BorderRadius cardBorderRadius;
  final double cardElevation;
  final double spacing;
  final EdgeInsets containerPadding;
}


final lightAppTheme = MyTheme(
  background: Colors.white,
  surface: Colors.white,
  primary: Colors.blue,
  secondary: Colors.grey,
  textPrimary: Colors.black,
  textSecondary: Colors.grey,
  headlineStyle: TextStyles.font24BlackBold,
  bodyStyle: TextStyles.font16BlackMedium,
  captionStyle: TextStyles.font14GreyRegular,
  buttonStyle: TextStyles.font14BlackRegular,
  cardBorderRadius: BorderRadius.circular(12),
  cardElevation: 2,
  spacing: 16,
  containerPadding: const EdgeInsets.all(16),
);

final darkAppTheme = MyTheme(
  background: Colors.black,
  surface: Colors.black,
  primary: Colors.blue,
  secondary: Colors.grey,
  textPrimary: Colors.white,
  textSecondary: Colors.grey,
  headlineStyle: TextStyles.font24WhiteBold,
  bodyStyle: TextStyles.font16WhiteMedium,
  captionStyle: TextStyles.font14GreyRegular,
  buttonStyle: TextStyles.font14WhiteRegular,
  cardBorderRadius: BorderRadius.circular(12),
  cardElevation: 2,
  spacing: 16,
  containerPadding: const EdgeInsets.all(16),
);