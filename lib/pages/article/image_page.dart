import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({
    super.key,
    required this.image,
    required this.index,
  });

  final String image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Hero(
        tag: 'post$index',
        transitionOnUserGestures: true,
        child: InteractiveViewer(
          child: CacheImage(
            imageUrl: image,
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
