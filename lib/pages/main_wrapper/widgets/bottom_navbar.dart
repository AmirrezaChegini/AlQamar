import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/search/search_page.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List<String> bottomTexts = [];
  final List<String> bottomIcons = const [
    AppIcons.home,
    AppIcons.topics,
    AppIcons.search,
    AppIcons.money,
    AppIcons.calender,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bottomTexts = [
      'home'.localize(context),
      'topics'.localize(context),
      'search'.localize(context),
      'subscribe'.localize(context),
      'works'.localize(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10).copyWith(bottom: 20),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(AppImages.navbar),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            blurRadius: 100,
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          TabBar(
            controller: widget.tabController,
            unselectedLabelColor: AppColors.grey600,
            labelColor: AppColors.blue,
            indicatorColor: AppColors.blue,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(0),
            labelPadding: const EdgeInsets.all(0),
            splashBorderRadius: BorderRadius.circular(20),
            onTap: (value) =>
                BlocProvider.of<BottomnavCubit>(context).changeIndex(value),
            tabs: List.generate(
              widget.tabController.length,
              (index) => index == 2
                  ? const SizedBox()
                  : Tab(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<BottomnavCubit, int>(
                            builder: (context, state) => AppIcon(
                              icon: bottomIcons[index],
                              width: index == 3 || index == 4 ? 23 : 25,
                              height: index == 3 || index == 4 ? 23 : 25,
                              color: index == state
                                  ? AppColors.blue
                                  : AppColors.grey600,
                            ),
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
          Positioned(
            top: -8,
            child: Material(
              shape: const CircleBorder(),
              color: AppColors.blue,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.transparent,
                      isDismissible: true,
                      builder: (context) => DraggableScrollableSheet(
                        minChildSize: 0.8,
                        maxChildSize: 1,
                        initialChildSize: 1,
                        builder: (context, scrollController) =>
                            SearchPage(scrollController: scrollController),
                      ),
                    );
                  },
                  icon: AppIcon(
                    icon: bottomIcons[2],
                    color: AppColors.white,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
