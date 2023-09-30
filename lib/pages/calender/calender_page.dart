import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/pages/calender/widgets/four_actions.dart';
import 'package:al_qamar/pages/calender/widgets/monthly_calender.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const MainAppbar(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: MonthlyCalender(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: AzanWidget(
                  city: 'نجف',
                  azanTime: AzanTime(
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                    '0',
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FourActions(),
            ),
          ),
        ],
      ),
    );
  }
}
