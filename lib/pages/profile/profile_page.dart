import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/bookmark/bookmark_page.dart';
import 'package:al_qamar/pages/profile/widgets/header_profile.dart';
import 'package:al_qamar/pages/profile/widgets/item_widget.dart';
import 'package:al_qamar/pages/profile/widgets/mini_calender.dart';
import 'package:al_qamar/pages/salavat/salavat_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: HeaderProfile(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: ItemWidget(
                          image: AppIcons.play,
                          color: AppColors.red.withOpacity(0.4),
                          title: 'بعیش',
                          height: 40,
                          width: 40,
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
                                      image: AppIcons.live,
                                      color: AppColors.grey600,
                                      title: 'برامج',
                                    ),
                                  ),
                                  Expanded(
                                    child: ItemWidget(
                                      onTap: () => Navigator.push(
                                          context,
                                          fadePageTran(
                                              child: const BookmarkPage())),
                                      image: AppIcons.bookmark,
                                      color: AppColors.grey600,
                                      title: 'المفضلة',
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
                                      color: AppColors.grey600,
                                      title: 'معلومات عنا',
                                    ),
                                  ),
                                  Expanded(
                                    child: ItemWidget(
                                      image: AppIcons.salavat,
                                      color: AppColors.grey600,
                                      title: 'صلوات',
                                      onTap: () => Navigator.push(
                                        context,
                                        fadePageTran(
                                            child: const SalavatPage()),
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
                BlocBuilder<AzanBloc, AzanState>(
                  builder: (context, state) {
                    if (state is CompletedAzanState) {
                      return Column(
                        children: List.generate(
                          state.azanTimeList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: AzanWidget(
                              city: index == 0 ? 'نجف' : 'لندن',
                              azanTime: state.azanTimeList[index],
                              backgroundColor: AppColors.grey200,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                            .copyWith(bottom: 10),
                    child: MiniCalender(),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 1,
                color: AppColors.grey200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: IconBtn(
                  onTap: () {},
                  padding: 10,
                  child: const AppIcon(
                    icon: AppIcons.setting,
                    width: 20,
                    height: 20,
                    color: AppColors.grey600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
