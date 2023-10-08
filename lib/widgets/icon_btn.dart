import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  const IconBtn({
    super.key,
    this.onTap,
    required this.child,
    this.padding = 5,
  });
  final Function()? onTap;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      minWidth: 0,
      height: 0,
      padding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
