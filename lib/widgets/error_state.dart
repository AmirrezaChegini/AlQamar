import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.errorMessage,
    required this.onTap,
    this.width,
    this.height,
    this.bottomMargin = 120,
  });

  final String errorMessage;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.wifi,
          width: width ?? MediaQuery.sizeOf(context).width / 2,
          height: height ?? MediaQuery.sizeOf(context).height / 3,
        ),
        Text(
          errorMessage.localize(context),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
        ),
        Text(
          'internetError'.localize(context),
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
          ),
          child: Text('tryagain'.localize(context)),
        ),
        SizedBox(height: bottomMargin),
      ],
    );
  }
}
