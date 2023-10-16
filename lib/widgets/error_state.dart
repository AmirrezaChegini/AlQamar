import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

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
        const SizedBox(height: 120),
      ],
    );
  }
}
