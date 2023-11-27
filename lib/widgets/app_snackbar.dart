import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

dynamic showMessage({
  required BuildContext context,
  required String content,
  int duration = 2,
  double horizontalMargin = 48,
  double verticalMargin = 80,
  SnackBarAction? action,
  bool isError = true,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: isError
            ? Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14)
            : Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
      ),
      backgroundColor: isError ? AppColors.red100 : AppColors.cyan,
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      dismissDirection: DismissDirection.horizontal,
      padding: EdgeInsets.symmetric(
        vertical: action == null ? 18 : 5,
        horizontal: 10,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      action: action,
    ),
  );
}
