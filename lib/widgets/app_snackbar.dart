import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

dynamic showMessage({
  required BuildContext context,
  required String content,
  SnackBarAction? action,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style:
            Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 13),
      ),
      backgroundColor: AppColors.red100,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      dismissDirection: DismissDirection.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      margin: const EdgeInsets.all(20).copyWith(bottom: 100),
      action: action,
    ),
  );
}
