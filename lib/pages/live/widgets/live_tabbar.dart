import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:flutter/material.dart';

class LiveTabbar extends StatelessWidget {
  const LiveTabbar({
    super.key,
    required TabController tabCtrl,
  }) : _tabCtrl = tabCtrl;

  final TabController _tabCtrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 1,
          color: AppColors.grey600,
        ),
        TabBar(
          controller: _tabCtrl,
          unselectedLabelColor: AppColors.grey600,
          labelColor: AppColors.blue,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: Fontsize.big),
          tabs: [
            Tab(text: 'video'.localize(context)),
            Tab(text: 'audio'.localize(context)),
          ],
        ),
      ],
    );
  }
}
