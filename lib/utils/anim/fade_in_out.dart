import 'package:flutter/material.dart';

class FadeOutAnim extends StatefulWidget {
  const FadeOutAnim({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final bool state;

  @override
  State<FadeOutAnim> createState() => _FadeOutAnimState();
}

class _FadeOutAnimState extends State<FadeOutAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeOutAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    _fadeOutAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
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
    widget.state
        ? _controller.forward().orCancel
        : _controller.reverse().orCancel;
    return FadeTransition(
      opacity: _fadeOutAnim,
      child: widget.child,
    );
  }
}
