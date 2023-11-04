import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.image,
    this.color = AppColors.black,
    this.onTap,
    this.width = 30,
    this.height = 30,
  });

  final String title;
  final String image;
  final Color color;
  final Function()? onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.grey200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(
              icon: image,
              color: color,
              height: height,
              width: width,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
