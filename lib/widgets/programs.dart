import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  const Programs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 12,
          ),
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text:
                '....................................................................',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
          ),
          TextSpan(
            text: '23:15',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
        text: 'العنوان الأول برامج',
      ),
    );
  }
}
