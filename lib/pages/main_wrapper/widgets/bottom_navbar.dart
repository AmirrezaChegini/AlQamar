import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    super.key,
    required this.tabCtrl,
  });

  final TabController tabCtrl;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<String> bottomTexts = const [
    'اعمال',
    'الاشتراک',
    'یبحث',
    'المواضیع',
    'بیت',
  ];

  final List<String> bottomIcons = const [
    AppIcons.calender,
    AppIcons.money,
    AppIcons.search,
    AppIcons.topics,
    AppIcons.home,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TabBar(
        controller: widget.tabCtrl,
        unselectedLabelColor: AppColors.grey,
        labelColor: AppColors.blue,
        indicatorColor: AppColors.blue,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.all(0),
        splashBorderRadius: BorderRadius.circular(20),
        onTap: (value) {
          setState(() {});
        },
        tabs: List.generate(
          widget.tabCtrl.length,
          (index) => Tab(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon: bottomIcons[index],
                  width: 25,
                  height: 25,
                  color: widget.tabCtrl.index == index
                      ? AppColors.blue
                      : AppColors.grey,
                ),
                const SizedBox(height: 6),
                Text(
                  bottomTexts[index],
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
