import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/painter/curved_painter.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  const TabItem(
      {super.key,
      required this.tabsIcon,
      required this.tabsText,
      required this.state});

  final String tabsIcon;
  final String tabsText;
  final bool state;

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> with TickerProviderStateMixin {
  late final AnimationController _animCtrl;
  late final Animation<Color?> _colorAnim;
  late final Animation<double> _point0Value;
  late final Animation<double> _point10Value;
  late final Animation<double> _point70Value;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _colorAnim = ColorTween(begin: AppColors.white, end: AppColors.red)
        .animate(_animCtrl);
    _point0Value = Tween<double>(begin: 80, end: 0).animate(_animCtrl);
    _point10Value = Tween<double>(begin: 80, end: 10).animate(_animCtrl);
    _point70Value = Tween<double>(begin: 80, end: 70).animate(_animCtrl);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state) {
      _animCtrl.forward();
    } else {
      _animCtrl.reverse();
    }
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _animCtrl,
        builder: (context, child) => CustomPaint(
          painter: CurvedPainter(
            value0: _point0Value.value,
            value10: _point10Value.value,
            value70: _point70Value.value,
          ),
          child: Tab(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppIcon(
                  icon: widget.tabsIcon,
                  height: 23,
                  width: 23,
                  color: _colorAnim.value,
                ),
                Text(
                  widget.tabsText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 11, color: _colorAnim.value),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
