import 'package:flutter/material.dart';

class FadeRotateAnim extends StatefulWidget {
  const FadeRotateAnim({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<FadeRotateAnim> createState() => _FadeRotateAnimState();
}

class _FadeRotateAnimState extends State<FadeRotateAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      reverseDuration: const Duration(seconds: 3),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _rotateAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _fadeAnim,
      child: RotationTransition(
        turns: _rotateAnim,
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
