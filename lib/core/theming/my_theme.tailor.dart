// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'my_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$MyThemeTailorMixin on ThemeExtension<MyTheme> {
  Color get background;
  Color get surface;
  Color get primary;
  Color get secondary;
  Color get textPrimary;
  Color get textSecondary;
  TextStyle get headlineStyle;
  TextStyle get bodyStyle;
  TextStyle get captionStyle;
  TextStyle get buttonStyle;
  BorderRadius get cardBorderRadius;
  double get cardElevation;
  double get spacing;
  EdgeInsets get containerPadding;

  @override
  MyTheme copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? secondary,
    Color? textPrimary,
    Color? textSecondary,
    TextStyle? headlineStyle,
    TextStyle? bodyStyle,
    TextStyle? captionStyle,
    TextStyle? buttonStyle,
    BorderRadius? cardBorderRadius,
    double? cardElevation,
    double? spacing,
    EdgeInsets? containerPadding,
  }) {
    return MyTheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      headlineStyle: headlineStyle ?? this.headlineStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      captionStyle: captionStyle ?? this.captionStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
      cardElevation: cardElevation ?? this.cardElevation,
      spacing: spacing ?? this.spacing,
      containerPadding: containerPadding ?? this.containerPadding,
    );
  }

  @override
  MyTheme lerp(covariant ThemeExtension<MyTheme>? other, double t) {
    if (other is! MyTheme) return this as MyTheme;
    return MyTheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      headlineStyle: TextStyle.lerp(headlineStyle, other.headlineStyle, t)!,
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t)!,
      captionStyle: TextStyle.lerp(captionStyle, other.captionStyle, t)!,
      buttonStyle: TextStyle.lerp(buttonStyle, other.buttonStyle, t)!,
      cardBorderRadius: t < 0.5 ? cardBorderRadius : other.cardBorderRadius,
      cardElevation: t < 0.5 ? cardElevation : other.cardElevation,
      spacing: t < 0.5 ? spacing : other.spacing,
      containerPadding: t < 0.5 ? containerPadding : other.containerPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyTheme &&
            const DeepCollectionEquality()
                .equals(background, other.background) &&
            const DeepCollectionEquality().equals(surface, other.surface) &&
            const DeepCollectionEquality().equals(primary, other.primary) &&
            const DeepCollectionEquality().equals(secondary, other.secondary) &&
            const DeepCollectionEquality()
                .equals(textPrimary, other.textPrimary) &&
            const DeepCollectionEquality()
                .equals(textSecondary, other.textSecondary) &&
            const DeepCollectionEquality()
                .equals(headlineStyle, other.headlineStyle) &&
            const DeepCollectionEquality().equals(bodyStyle, other.bodyStyle) &&
            const DeepCollectionEquality()
                .equals(captionStyle, other.captionStyle) &&
            const DeepCollectionEquality()
                .equals(buttonStyle, other.buttonStyle) &&
            const DeepCollectionEquality()
                .equals(cardBorderRadius, other.cardBorderRadius) &&
            const DeepCollectionEquality()
                .equals(cardElevation, other.cardElevation) &&
            const DeepCollectionEquality().equals(spacing, other.spacing) &&
            const DeepCollectionEquality()
                .equals(containerPadding, other.containerPadding));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(background),
      const DeepCollectionEquality().hash(surface),
      const DeepCollectionEquality().hash(primary),
      const DeepCollectionEquality().hash(secondary),
      const DeepCollectionEquality().hash(textPrimary),
      const DeepCollectionEquality().hash(textSecondary),
      const DeepCollectionEquality().hash(headlineStyle),
      const DeepCollectionEquality().hash(bodyStyle),
      const DeepCollectionEquality().hash(captionStyle),
      const DeepCollectionEquality().hash(buttonStyle),
      const DeepCollectionEquality().hash(cardBorderRadius),
      const DeepCollectionEquality().hash(cardElevation),
      const DeepCollectionEquality().hash(spacing),
      const DeepCollectionEquality().hash(containerPadding),
    );
  }
}

extension MyThemeBuildContextProps on BuildContext {
  MyTheme get myTheme => Theme.of(this).extension<MyTheme>()!;
  Color get background => myTheme.background;
  Color get surface => myTheme.surface;
  Color get primary => myTheme.primary;
  Color get secondary => myTheme.secondary;
  Color get textPrimary => myTheme.textPrimary;
  Color get textSecondary => myTheme.textSecondary;
  TextStyle get headlineStyle => myTheme.headlineStyle;
  TextStyle get bodyStyle => myTheme.bodyStyle;
  TextStyle get captionStyle => myTheme.captionStyle;
  TextStyle get buttonStyle => myTheme.buttonStyle;
  BorderRadius get cardBorderRadius => myTheme.cardBorderRadius;
  double get cardElevation => myTheme.cardElevation;
  double get spacing => myTheme.spacing;
  EdgeInsets get containerPadding => myTheme.containerPadding;
}
