import 'package:al_qamar/bloc/bookmark/bookmark_bloc.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkBloc>(context).add(GetAllBookmark());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'favorite'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<BookmarkBloc, BookmarkState>(
          builder: (context, state) {
            if (state is CompleteBookmarkState) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.bookmarkList.length,
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ArticleWidget(
                            article: state.bookmarkList[index],
                            onTap: () =>
                                BlocProvider.of<BookmarkBloc>(context).add(
                              Removebookmark(state.bookmarkList[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is EmptyBookmarkState) {
              return Center(child: Image.asset(AppImages.blank));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
