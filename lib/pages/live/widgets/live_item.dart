import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class LiveItem extends StatelessWidget {
  const LiveItem({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: AppColors.grey600,
        ),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
