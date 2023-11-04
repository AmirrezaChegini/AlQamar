import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class LiveItem extends StatelessWidget {
  const LiveItem({
    super.key,
    required this.title,
    required this.color,
    this.onTap,
  });

  final String title;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.sizeOf(context).width / 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: AppColors.grey600,
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
        ),
      ),
    );
  }
}
