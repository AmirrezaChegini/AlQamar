import 'package:flutter/material.dart';

class SlideUpAnim extends StatefulWidget {
  const SlideUpAnim({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final bool state;

  @override
  State<SlideUpAnim> createState() => _SlideUpAnimState();
}

class _SlideUpAnimState extends State<SlideUpAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _animation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.state ? _controller.forward() : _controller.reverse();

    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
