import 'package:al_qamar/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class MaskImage extends StatelessWidget {
  const MaskImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return WidgetMask(
      childSaveLayer: true,
      blendMode: BlendMode.srcIn,
      mask: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment.centerLeft,
      ),
      child: Image.asset(
        AppImages.imageHolder1,
      ),
    );
  }
}
