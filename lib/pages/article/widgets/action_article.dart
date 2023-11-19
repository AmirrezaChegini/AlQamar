import 'package:al_qamar/bloc/bookmark/bookmark_bloc.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_event.dart';
import 'package:al_qamar/bloc/favorite/favorite_bloc.dart';
import 'package:al_qamar/bloc/favorite/favorite_event.dart';
import 'package:al_qamar/bloc/favorite/favorite_state.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bookmark_cubit.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_item.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/share.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionArticle extends StatelessWidget {
  const ActionArticle({
    super.key,
    required this.article,
  });

  final Article article;

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
              BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  return ActionItem(
                    onTap: () {
                      state is TrueFavoriteState
                          ? BlocProvider.of<FavoriteBloc>(context)
                              .add(RemoveFavorite(article))
                          : BlocProvider.of<FavoriteBloc>(context)
                              .add(AddFavorite(article));
                    },
                    icon: state is TrueFavoriteState
                        ? AppIcons.favoriteFill
                        : AppIcons.favorite,
                    color: AppColors.red,
                  );
                },
              ),
              const SizedBox(width: 8),
              ActionItem(
                onTap: () => ShareData.share(article.content.htmlToString()),
                icon: AppIcons.share,
                color: AppColors.blue,
              ),
              const SizedBox(width: 8),
              BlocBuilder<BookmarkCubit, bool>(
                builder: (context, state) {
                  return ActionItem(
                    onTap: () {
                      state
                          ? BlocProvider.of<BookmarkBloc>(context)
                              .add(Removebookmark(article))
                          : BlocProvider.of<BookmarkBloc>(context)
                              .add(AddBookmark(article));
                    },
                    icon: state ? AppIcons.bookmarkFill : AppIcons.bookmark,
                    color: AppColors.blue,
                  );
                },
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
                        ' ${article.updateAt}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
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
                        ' ${article.writer}',
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
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
