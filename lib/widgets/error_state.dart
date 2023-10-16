import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.errorMessage,
    required this.onTap,
  });

  final String errorMessage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppIcons.wifi,
          width: MediaQuery.sizeOf(context).width / 2,
          height: MediaQuery.sizeOf(context).height / 3,
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
        const SizedBox(height: 120),
      ],
    );
  }
}
