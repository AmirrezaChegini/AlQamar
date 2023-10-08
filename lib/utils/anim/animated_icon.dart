import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class IconAnimated extends StatefulWidget {
  const IconAnimated({
    super.key,
    required this.icon,
    required this.state,
    this.color = AppColors.black,
    this.size,
  });

  final AnimatedIconData icon;
  final bool state;
  final Color color;
  final double? size;

  @override
  State<IconAnimated> createState() => _IconAnimatedState();
}

class _IconAnimatedState extends State<IconAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.state ? _controller.forward() : _controller.reverse();
    return AnimatedIcon(
      icon: widget.icon,
      progress: _animation,
      size: widget.size,
      color: widget.color,
    );
  }
}
