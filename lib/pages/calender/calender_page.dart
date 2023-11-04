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
        // BlocBuilder<AzanBloc, AzanState>(
        //   builder: (context, state) {
        //     if (state is CompletedAzanState) {
        //       return SliverList(
        //         delegate: SliverChildBuilderDelegate(
        //           childCount: state.azanTimeList.length,
        //           (context, index) => Padding(
        //             padding: const EdgeInsets.all(10),
        //             child: AzanWidget(
        //               city: index == 0
        //                   ? 'najaf'.localize(context)
        //                   : 'london'.localize(context),
        //               azanTime: state.azanTimeList[index],
        //             ),
        //           ),
        //         ),
        //       );
        //     } else {
        //       return const SliverToBoxAdapter();
        //     }
        //   },
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10).copyWith(bottom: 100),
            child: const FourActions(),
          ),
        ),
      ],
    );
  }
}
