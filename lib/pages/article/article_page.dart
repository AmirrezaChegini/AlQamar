import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/audio_page.dart';
import 'package:al_qamar/pages/article/image_page.dart';
import 'package:al_qamar/pages/article/pdf_page.dart';
import 'package:al_qamar/pages/article/video_page.dart';
import 'package:al_qamar/pages/article/widgets/article_tabbar.dart';
import 'package:al_qamar/pages/article/youtube_page.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<String> tabsText;
  final List<String> tabsIcon = const [
    AppIcons.image,
    AppIcons.video,
    AppIcons.youtube,
    AppIcons.audio,
    AppIcons.pdf
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabsText = [
      'photo'.localize(context),
      'video'.localize(context),
      'youtube'.localize(context),
      'audio'.localize(context),
      'document'.localize(context),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) => NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              ArticleTabbar(
                tabController: _tabController,
                tabsIcon: tabsIcon,
                tabsText: tabsText,
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ImagePage(article: widget.article),
                VideoPage(article: widget.article),
                YoutubePage(article: widget.article),
                AudioPage(article: widget.article),
                PdfPage(article: widget.article),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
