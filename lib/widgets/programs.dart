import 'package:al_qamar/models/program.dart';
import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  const Programs({
    super.key,
    required this.program,
  });

  final Program program;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text:
                ' .................................................................... ',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
          ),
          TextSpan(
            text: program.time,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
        text: program.name,
      ),
    );
  }
}
