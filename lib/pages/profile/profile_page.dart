import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/profile/widgets/azan_widget.dart';
import 'package:al_qamar/pages/profile/widgets/header_profile.dart';
import 'package:al_qamar/pages/profile/widgets/item_widget.dart';
import 'package:al_qamar/pages/profile/widgets/mini_calender.dart';
import 'package:al_qamar/pages/salavat/salavat_page.dart';
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
                  image: AppIcons.youTube,
                  color: AppColors.red,
                  title: 'بعیش',
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ItemWidget(
                              image: AppIcons.live,
                              title: 'برامج',
                            ),
                          ),
                          Expanded(
                            child: ItemWidget(
                              image: AppIcons.calendar,
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
                              image: AppIcons.profile,
                              title: 'معلومات عنا',
                            ),
                          ),
                          Expanded(
                            child: ItemWidget(
                              image: AppIcons.salavat,
                              title: 'صلوات',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SalavatPage()),
                                );
                              },
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
            icon: Image.asset(
              AppIcons.setting,
              width: 20,
              height: 20,
              color: AppColors.grey600,
            ),
            padding: const EdgeInsets.all(0),
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
