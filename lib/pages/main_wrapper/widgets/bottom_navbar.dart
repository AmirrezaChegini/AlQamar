import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bottom_nav_cubit.dart';
import 'package:al_qamar/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    super.key,
    required this.tabCtrl,
    required this.animCtrl,
  });

  final TabController tabCtrl;
  final AnimationController animCtrl;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<String> bottomTexts = const [
    'اعمال',
    'حساب',
    'یبحث',
    'المواضیع',
    'بیت',
  ];

  final List<String> bottomIcons = const [
    AppIcons.calender,
    AppIcons.profile,
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
          if (value == 2) {
            showBottomSheet(
              context: context,
              transitionAnimationController: widget.animCtrl,
              builder: (context) => const SearchPage(),
              backgroundColor: AppColors.transparent,
            );
            int index = BlocProvider.of<BottomnavCubit>(context).index;
            widget.tabCtrl.animateTo(index);
          } else {
            BlocProvider.of<BottomnavCubit>(context).saveIndex(value);
            if (widget.animCtrl.isCompleted) {
              Navigator.pop(context);
            }
          }
          setState(() {});
        },
        tabs: List.generate(
          widget.tabCtrl.length,
          (index) => Tab(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  bottomIcons[index],
                  width: 30,
                  height: 30,
                  color: widget.tabCtrl.index == index
                      ? AppColors.blue
                      : AppColors.grey,
                ),
                const SizedBox(height: 4),
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
