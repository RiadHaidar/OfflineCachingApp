import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font24BlackBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle font20BlackSemiBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.textPrimary,
  );

  static TextStyle font18BlackMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.textPrimary,
  );

  static TextStyle font16BlackMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.textPrimary,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textSecondary,
  );

  static TextStyle font14BlackRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textPrimary,
  );

  static TextStyle font12GreyRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.textSecondary,
  );
}
