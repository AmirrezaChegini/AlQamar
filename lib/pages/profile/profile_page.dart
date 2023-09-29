import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/calender_page.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:al_qamar/pages/profile/widgets/header_profile.dart';
import 'package:al_qamar/pages/profile/widgets/item_widget.dart';
import 'package:al_qamar/pages/profile/widgets/mini_calender.dart';
import 'package:al_qamar/pages/salavat/salavat_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          child: HeaderProfile(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Row(
            children: [
              const Expanded(
                child: ItemWidget(
                  image: AppIcons.play,
                  color: AppColors.red,
                  title: 'بعیش',
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: ItemWidget(
                              image: AppIcons.tv,
                              title: 'برامج',
                            ),
                          ),
                          Expanded(
                            child: ItemWidget(
                              onTap: () => Navigator.push(
                                context,
                                fadePageTran(child: const CalenderPage()),
                              ),
                              image: AppIcons.calender,
                              color: AppColors.grey,
                              title: 'تقویم',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: ItemWidget(
                              image: AppIcons.aboutUs,
                              title: 'معلومات عنا',
                            ),
                          ),
                          Expanded(
                            child: ItemWidget(
                              image: AppIcons.salavat,
                              title: 'صلوات',
                              onTap: () => Navigator.push(
                                context,
                                fadePageTran(child: const SalavatPage()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ...List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: AzanWidget(),
          ),
        ),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: MiniCalender(),
          ),
        ),
        Container(
          height: 1,
          color: AppColors.grey,
          margin: const EdgeInsets.symmetric(horizontal: 10),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: IconButton(
            onPressed: () {},
            icon: const SvgIcon(
              icon: AppIcons.setting,
              width: 20,
              height: 20,
            ),
            padding: const EdgeInsets.all(0),
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
