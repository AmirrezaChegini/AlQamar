import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/pages/article/widgets/tab_item.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleTabbar extends StatefulWidget implements PreferredSizeWidget {
  const ArticleTabbar({
    super.key,
    required this.tabController,
    required this.audios,
    required this.videos,
    required this.pdfs,
  });

  final TabController tabController;
  final List<dynamic> audios;
  final List<dynamic> videos;
  final List<dynamic> pdfs;

  @override
  State<ArticleTabbar> createState() => _ArticleTabbarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _ArticleTabbarState extends State<ArticleTabbar> {
  final List<String> _tabsIcon = const [
    AppIcons.image,
    AppIcons.video,
    AppIcons.youtube,
    AppIcons.audio,
    AppIcons.pdf
  ];
  late final List<String> _tabsText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabsText = [
      'photo'.localize(context),
      'video'.localize(context),
      'youtube'.localize(context),
      'audio'.localize(context),
      'document'.localize(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
      ),
      title: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.blue,
              AppColors.blue.withOpacity(0.7),
              AppColors.blue.withOpacity(0.7),
              AppColors.blue,
            ],
          ),
        ),
        child: TabBar(
          controller: widget.tabController,
          labelPadding: const EdgeInsets.all(0),
          onTap: (value) {
            if ((value == 1 && widget.videos.isEmpty) ||
                (value == 3 && widget.audios.isEmpty) ||
                (value == 4 && widget.pdfs.isEmpty)) {
              widget.tabController
                  .animateTo(widget.tabController.previousIndex);

              showMessage(
                context: context,
                content: 'noContent'.localize(context),
                horizontalMargin: 10,
                verticalMargin: 10,
                isError: false,
              );
            } else {
              BlocProvider.of<ArticleCubit>(context).changeIndex(value);
              setState(() {});
            }
          },
          tabs: List.generate(
            5,
            (index) => TabItem(
              tabsIcon: _tabsIcon[index],
              tabsText: _tabsText[index],
              state: widget.tabController.index == index,
            ),
          ),
        ),
      ),
    );
  }
}
