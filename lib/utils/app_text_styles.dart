import 'package:flutter/material.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';

abstract class AppTextStyles {
  static const titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 34, 34, 34),
  );

  static const primaryTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static const buttonTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );
}
