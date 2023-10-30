import 'package:al_qamar/bloc/bookmark/bookmark_bloc.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/loading_state.dart';
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

    BlocProvider.of<BookmarkBloc>(context).add(GetAllBookmarkEvent());
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
        child: BlocConsumer<BookmarkBloc, BookmarkState>(
          listener: (context, state) {
            if (state is FailBookmarkState) {
              showMessage(
                context: context,
                content: state.errorMessage.localize(context),
                horizontalMargin: 10,
                verticalMargin: 10,
              );
            }

            if (state is CompleteRemoveBookmarkState) {
              showMessage(
                context: context,
                content: state.message,
                horizontalMargin: 10,
                verticalMargin: 10,
              );
            }
          },
          builder: (context, state) {
            if (state is CompleteBookmarkState) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.bookmarkList.length,
                        (context, index) => Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) =>
                              BlocProvider.of<BookmarkBloc>(context).add(
                                  RemoveBookmarkEvent(
                                      state.bookmarkList[index].id)),
                          background: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'remove'.localize(context),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ArticleWidget(
                                article: state.bookmarkList[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is LoadingBookmarkState) {
              return const LoadingState();
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
