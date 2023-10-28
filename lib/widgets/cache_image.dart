import 'package:al_qamar/constants/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      errorWidget: (context, url, error) => Image.asset(
        AppImages.error,
        fit: BoxFit.cover,
      ),
      fit: BoxFit.cover,
    );
  }
}
