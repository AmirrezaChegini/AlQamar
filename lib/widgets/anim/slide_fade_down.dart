import 'package:flutter/material.dart';

class SlideFadeDownAnim extends StatefulWidget {
  const SlideFadeDownAnim({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final bool state;

  @override
  State<SlideFadeDownAnim> createState() => _SlideFadeDownAnimState();
}

class _SlideFadeDownAnimState extends State<SlideFadeDownAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _fadeAnim = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnim = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.state ? _controller.forward() : _controller.reverse();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: widget.child,
        ),
      ),
    );
  }
}
