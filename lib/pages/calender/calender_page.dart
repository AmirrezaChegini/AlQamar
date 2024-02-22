import 'package:al_qamar/pages/calender/widgets/four_actions.dart';
import 'package:al_qamar/pages/calender/widgets/monthly_calender.dart';
import 'package:flutter/material.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: MonthlyCalender(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10).copyWith(bottom: 120),
            child: const FourActions(),
          ),
        ),
      ],
    );
  }
}
