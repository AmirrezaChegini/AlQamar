import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';

class FourActions extends StatelessWidget {
  const FourActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'wednesdayBusiness'.localize(context),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 1,
                  color: AppColors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => TxtBtn(
                onTap: () => Navigator.push(
                  context,
                  fadePageTran(
                      child: ArticlePage(
                    article:
                        Article(1, 1, '', '', '', '', '', '', [], [], [], []),
                  )),
                ),
                title: 'دعا کمیل بن الزیاد',
                icon: AppIcons.rightArrow,
                textDecoration: CheckDirect.isRTL(context)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            ),
          )
        ],
      ),
    );
  }
}
