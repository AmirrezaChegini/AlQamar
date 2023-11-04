import 'package:al_qamar/bloc/bookmark/bookmark_bloc.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bookmark_cubit.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/pages/article/widgets/action_item.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/share.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionArticle extends StatefulWidget {
  const ActionArticle({
    super.key,
    this.article,
    this.calender,
  });

  final Article? article;
  final Calender? calender;

  @override
  State<ActionArticle> createState() => _ActionArticleState();
}

class _ActionArticleState extends State<ActionArticle> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      BlocProvider.of<BookmarkCubit>(context).isBookmarked(widget.article!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ActionItem(
                onTap: () => setState(() {
                  isLiked = !isLiked;
                }),
                icon: isLiked ? AppIcons.favoriteFill : AppIcons.favorite,
                color: AppColors.red,
              ),
              const SizedBox(width: 8),
              ActionItem(
                onTap: () => widget.article != null
                    ? ShareData.share(widget.article!.content.htmlToString())
                    : ShareData.share(widget.calender!.content.htmlToString()),
                icon: AppIcons.share,
                color: AppColors.blue,
              ),
              const SizedBox(width: 8),
              BlocBuilder<BookmarkCubit, bool>(
                builder: (context, state) => ActionItem(
                  onTap: () => setState(() {
                    if (widget.article != null) {
                      BlocProvider.of<BookmarkCubit>(context).changeBookmark();
                    }

                    if (widget.article != null && !state) {
                      BlocProvider.of<BookmarkBloc>(context)
                          .add(AddBookmarkEvent(widget.article!.id));
                    }
                    if (widget.article != null && state) {
                      BlocProvider.of<BookmarkBloc>(context)
                          .add(RemoveBookmarkEvent(widget.article!.id));
                    }
                  }),
                  icon: state ? AppIcons.bookmarkFill : AppIcons.bookmark,
                  color: AppColors.blue,
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const AppIcon(
                        icon: AppIcons.calender,
                        width: 15,
                        height: 15,
                        color: AppColors.black,
                      ),
                      Text(
                        widget.article != null
                            ? ' ${widget.article?.updateAt}'
                            : ' ${widget.calender?.updateAt}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  if (widget.article != null) ...{
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const AppIcon(
                          icon: AppIcons.pen,
                          width: 15,
                          height: 15,
                          color: AppColors.black,
                        ),
                        Text(
                          ' ${widget.article?.writer}',
                          softWrap: false,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  }
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            color: AppColors.grey600,
          )
        ],
      ),
    );
  }
}
