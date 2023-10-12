import 'package:flutter/material.dart';

class IconBtnAppbar extends StatelessWidget {
  const IconBtnAppbar({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 24,
      padding: const EdgeInsets.all(0),
      constraints: const BoxConstraints(
        maxWidth: 30,
        minWidth: 30,
      ),
      icon: child,
    );
  }
}
