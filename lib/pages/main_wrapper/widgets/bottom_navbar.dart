import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/search/search_page.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppIcons.calender,
    AppIcons.money,
    AppIcons.search,
    AppIcons.topics,
    AppIcons.home,
  ];

  void onTap(int value) {
    if (value == 2) {
      widget.tabController.animateTo(widget.tabController.previousIndex);
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
    } else {
      Navigator.maybePop(context);
    }

    BlocProvider.of<BottomnavCubit>(context).changeIndex(value);
  }

  @override
  Widget build(BuildContext context) {
    bottomTexts = [
      AppLocalizations.of(context)!.works,
      AppLocalizations.of(context)!.subscribe,
      AppLocalizations.of(context)!.search,
      AppLocalizations.of(context)!.topics,
      AppLocalizations.of(context)!.home,
    ];
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.5),
            blurRadius: 100,
            spreadRadius: 0,
          )
        ],
      ),
      child: TabBar(
        controller: widget.tabController,
        unselectedLabelColor: AppColors.grey,
        labelColor: AppColors.blue,
        indicatorColor: AppColors.blue,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.all(0),
        splashBorderRadius: BorderRadius.circular(20),
        onTap: (value) => onTap(value),
        tabs: List.generate(
          widget.tabController.length,
          (index) => Tab(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<BottomnavCubit, int>(
                  buildWhen: (previous, current) => current != 2,
                  builder: (context, state) => AppIcon(
                    icon: bottomIcons[index],
                    width: index == 1 ? 28 : 30,
                    height: index == 1 ? 28 : 30,
                    color: index == state ? AppColors.blue : AppColors.grey,
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
    );
  }
}
