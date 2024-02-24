import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/models/program.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: Fontsize.big),
        ),
        Expanded(
          child: Text('.' * 300, maxLines: 1),
        ),
        Text(
          DateFormat('HH:mm').format(program.date),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: Fontsize.big),
        ),
      ],
    );
  }
}
