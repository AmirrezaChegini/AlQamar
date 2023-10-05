import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArticleTabbar extends StatelessWidget {
  const ArticleTabbar({
    super.key,
    required this.tabController,
    required this.tabsIcon,
    required this.tabsText,
  });

  final TabController tabController;
  final List<String> tabsIcon;
  final List<String> tabsText;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 80,
      collapsedHeight: 80,
      backgroundColor: AppColors.grey200,
      elevation: 0,
      floating: true,
      snap: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: TabBar(
        controller: tabController,
        labelStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
        labelColor: AppColors.blue,
        unselectedLabelStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
        unselectedLabelColor: AppColors.grey,
        indicatorColor: AppColors.blue,
        indicatorWeight: 2,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
        tabs: List.generate(
          5,
          (index) => Tab(
            icon: SvgIcon(
              icon: tabsIcon[index],
              height: 20,
              width: 20,
              color: AppColors.grey,
            ),
            text: tabsText[index],
          ),
        ),
      ),
    );
  }
}
