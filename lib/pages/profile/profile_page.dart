import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/profile/widgets/header_profile.dart';
import 'package:al_qamar/pages/profile/widgets/item_widget.dart';
import 'package:al_qamar/pages/profile/widgets/mini_calender.dart';
import 'package:al_qamar/pages/salavat/salavat_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      color: AppColors.white,
      child: ListView(
        controller: scrollController,
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
                                onTap: () => Navigator.pop(context),
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
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                  .copyWith(bottom: 10),
              child: MiniCalender(),
            ),
          ),
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
              child: const SvgIcon(
                icon: AppIcons.setting,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
