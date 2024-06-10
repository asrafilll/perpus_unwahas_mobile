import 'package:flutter/material.dart';
import 'package:perpus_unwahas_mobile/utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.textButton,
  });

  final Function()? onTap;

  final String textButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        child: Center(
            child: Text(
          textButton,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
