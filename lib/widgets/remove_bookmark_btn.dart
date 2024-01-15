import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class RemoveBookmarkBtn extends StatelessWidget {
  const RemoveBookmarkBtn({
    super.key,
    this.ontap,
  });

  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}
