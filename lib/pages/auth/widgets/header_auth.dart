import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:flutter/material.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.red, AppColors.red],
          ).createShader(bounds),
          child: Container(
            height: MediaQuery.sizeOf(context).height / 6,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage(AppImages.authBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'welcome'.localize(context),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 18),
                ),
                Container(
                  height: 2,
                  color: AppColors.white,
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'sentenceOne'.localize(context),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 13),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FittedBox(
                child: Text('sentenceTwo'.localize(context),
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
