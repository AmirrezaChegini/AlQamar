import 'package:al_qamar/bloc/category/category_bloc.dart';
import 'package:al_qamar/bloc/category/category_state.dart';
import 'package:al_qamar/pages/category/widgets/category_item.dart';
import 'package:al_qamar/widgets/anim/fade_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CategoryBloc, CategorySate>(
      builder: (context, state) {
        if (state is CompleteCategoryState) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8).copyWith(bottom: 115),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.categoryList.length,
                    (context, index) => FadeSideAnim(
                      offset: index.isEven
                          ? const Offset(1, 0)
                          : const Offset(-1, 0),
                      duration: Duration(milliseconds: index * 100),
                      child: CategoryItem(
                        category: state.categoryList[index],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
