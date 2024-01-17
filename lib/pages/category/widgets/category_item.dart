import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/models/category.dart';
import 'package:al_qamar/pages/news/news_page.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          pageRoute(child: NewsPage(category: category)),
        ),
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CacheImage(
              imageUrl: category.photo,
              height: 80,
              width: 80,
            ),
            Text(
              category.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: Fontsize.huge),
            ),
          ],
        ),
      ),
    );
  }
}
