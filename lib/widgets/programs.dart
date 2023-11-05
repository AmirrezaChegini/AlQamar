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
    return Row(
      children: [
        Text(
          program.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Expanded(
          child: Text('.' * 100, maxLines: 1),
        ),
        Text(
          program.time,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
