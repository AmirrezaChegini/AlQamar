import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleTabbar extends StatefulWidget implements PreferredSizeWidget {
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
  State<ArticleTabbar> createState() => _ArticleTabbarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _ArticleTabbarState extends State<ArticleTabbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: AppColors.grey200,
      elevation: 0,
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.grey200,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 1,
            color: AppColors.grey600,
          ),
          TabBar(
            controller: widget.tabController,
            labelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
            labelColor: AppColors.blue,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
            unselectedLabelColor: AppColors.grey,
            indicatorColor: AppColors.blue,
            indicatorWeight: 2,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
            onTap: (value) {
              BlocProvider.of<ArticleCubit>(context).changeIndex(value);
              setState(() {});
            },
            tabs: List.generate(
              5,
              (index) => Tab(
                icon: AppIcon(
                  icon: widget.tabsIcon[index],
                  height: 25,
                  width: 25,
                  color: widget.tabController.index == index
                      ? AppColors.blue
                      : AppColors.grey,
                ),
                text: widget.tabsText[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
