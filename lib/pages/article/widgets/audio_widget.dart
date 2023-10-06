import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/utils/anim/animated_icon.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({
    super.key,
  });

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20).copyWith(),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          AppImages.img1,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'الجزء الأول',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const SvgIcon(
                                icon: AppIcons.calender,
                                width: 10,
                                height: 10,
                                color: AppColors.black,
                              ),
                              Text(
                                ' 1402/03/03',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SvgIcon(
                                icon: AppIcons.pen,
                                width: 10,
                                height: 10,
                                color: AppColors.black,
                              ),
                              Text(
                                ' بواسظ امیررضا چگینی',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 12,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: 20,
                      inactiveColor: AppColors.grey200,
                      activeColor: AppColors.blue,
                      overlayColor: MaterialStatePropertyAll(
                        AppColors.blue.withOpacity(0.1),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '00:20',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                      Text(
                        '12:30',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 5, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        '1.0 X',
                        textDirection: TextDirection.ltr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                      const Spacer(),
                      IconBtn(
                        onTap: () {},
                        child: const Icon(
                          Icons.skip_next_rounded,
                          color: AppColors.blue,
                          size: 40,
                        ),
                      ),
                      IconBtn(
                        onTap: () {},
                        child: IconAnimated(
                          icon: AnimatedIcons.play_pause,
                          state: state,
                          color: AppColors.blue,
                          size: 35,
                        ),
                      ),
                      IconBtn(
                        onTap: () {},
                        child: const Icon(
                          Icons.skip_previous_rounded,
                          color: AppColors.blue,
                          size: 40,
                        ),
                      ),
                      const Spacer(),
                      IconBtn(
                        onTap: () {},
                        child: const Icon(
                          Icons.refresh_rounded,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          delegate: ActionArticle(),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'التمهدیة الأولی اللحزب الجمهوری فی الدورة الانتخابیة',
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 16),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 5,
            (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  setState(() {
                    state = !state;
                  });
                },
                selected: false,
                tileColor: AppColors.white,
                selectedTileColor: AppColors.red100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                leading: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الجزء الأول',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        '01:22:32',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                trailing: IconAnimated(
                  icon: AnimatedIcons.play_pause,
                  state: state,
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TitleWidget(
              title: 'الاخبار مماتلة',
              showDivider: true,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 5,
            (context, index) => const Padding(
              padding: EdgeInsets.all(10),
              child: ArticleWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
