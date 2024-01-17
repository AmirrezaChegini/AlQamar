import 'package:flutter/material.dart';

class FadeInStaggeredAnim extends StatefulWidget {
  const FadeInStaggeredAnim({
    super.key,
    required this.child,
    required this.duration,
  });

  final Widget child;
  final Duration duration;

  @override
  State<FadeInStaggeredAnim> createState() => _FadeInStaggeredAnimState();
}

class _FadeInStaggeredAnimState extends State<FadeInStaggeredAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _fadeInAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    showAnim();
  }

  Future<void> showAnim() async {
    await Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnim,
      child: widget.child,
    );
  }
}
