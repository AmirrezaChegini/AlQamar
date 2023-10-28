import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: LottieBuilder.asset(
          'assets/video/animation.json',
          width: width ?? MediaQuery.sizeOf(context).width / 2,
          height: height ?? MediaQuery.sizeOf(context).height / 2,
          reverse: true,
        ),
      ),
    );
  }
}
