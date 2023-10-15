import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForceNews extends StatelessWidget {
  const ForceNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: CheckDirect.isRTL(context)
            ? BorderRadius.circular(8)
                .copyWith(bottomLeft: const Radius.circular(50))
            : BorderRadius.circular(8)
                .copyWith(bottomRight: const Radius.circular(50)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${AppLocalizations.of(context)!.news}\n${AppLocalizations.of(context)!.instant}',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16),
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الذکر الیوم لا اله الا الله الملک الحق المبین',
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  'ما الذی یجب المراقبة فی المناظرة التمهیدیة الأولی للحزب الجمهوری مراقبة فی المناظرة الأولی',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12),
                )
              ],
            ),
          ),
          Container(
            height: 70,
            alignment: Alignment.topCenter,
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: CheckDirect.isRTL(context)
                    ? BorderRadius.circular(4).copyWith(
                        bottomRight: const Radius.circular(15),
                      )
                    : BorderRadius.circular(4).copyWith(
                        bottomLeft: const Radius.circular(15),
                      ),
              ),
              child: const AppIcon(
                icon: AppIcons.rightArrow,
                color: AppColors.red,
                matchDirection: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
