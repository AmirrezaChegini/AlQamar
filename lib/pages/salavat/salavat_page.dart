import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/salavat/widgets/circle_widget.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class SalavatPage extends StatelessWidget {
  const SalavatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const MainAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                CircleWidget(
                  width: 250,
                  height: 250,
                  shadows: const [
                    BoxShadow(
                      color: AppColors.red,
                      offset: Offset(0, -10),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: AppColors.grey600,
                      offset: Offset(0, 10),
                      blurRadius: 15,
                    ),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '254',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 60),
                      ),
                      Container(
                        height: 1,
                        width: 60,
                        color: AppColors.grey,
                      ),
                      Text(
                        'سالافات',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 20),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: -80,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CircleWidget(
                      width: 55,
                      height: 55,
                      backgroundColor: AppColors.grey600,
                      shadows: const [
                        BoxShadow(
                          color: AppColors.grey600,
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          spreadRadius: -4,
                        ),
                      ],
                      child: Text(
                        'إلغاء',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: -150,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CircleWidget(
                      backgroundColor: AppColors.red,
                      height: 80,
                      width: 80,
                      shadows: const [
                        BoxShadow(
                          color: AppColors.grey600,
                          offset: Offset(5, 10),
                          blurRadius: 10,
                          spreadRadius: -4,
                        ),
                      ],
                      child: Text(
                        'محل',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) => Expanded(
                child: CircleWidget(
                  padding: 10,
                  shadows: const [
                    BoxShadow(
                      color: AppColors.grey600,
                      offset: Offset(5, 10),
                      blurRadius: 10,
                      spreadRadius: -4,
                    ),
                  ],
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '254',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: index == 0 || index == 2 ? 20 : 26,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        width: 30,
                        color: AppColors.grey,
                      ),
                      Text(
                        'سالافات',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: index == 0 || index == 2 ? 10 : 14,
                            ),
                      ),
                      const SizedBox(height: 5),
                      const CircleWidget(
                        padding: 8,
                        backgroundColor: AppColors.blue,
                        shadows: [
                          BoxShadow(
                            color: AppColors.grey600,
                            offset: Offset(5, 10),
                            blurRadius: 10,
                            spreadRadius: -4,
                          ),
                        ],
                        child: SvgIcon(
                          icon: AppIcons.rightArrow,
                          height: 20,
                          width: 20,
                          matchDirection: true,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
