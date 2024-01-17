import 'package:flutter/material.dart';

class FadeSideAnim extends StatefulWidget {
  const FadeSideAnim({
    super.key,
    required this.child,
    required this.offset,
    required this.duration,
  });

  final Widget child;
  final Offset offset;
  final Duration duration;

  @override
  State<FadeSideAnim> createState() => _FadeSideAnimState();
}

class _FadeSideAnimState extends State<FadeSideAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    showAnim();
  }

  Future<void> showAnim() async {
    await Future.delayed(widget.duration, () {
      _controller.forward();
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
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: widget.child,
      ),
    );
  }
}
