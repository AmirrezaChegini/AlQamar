import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/pages/calender/widgets/four_actions.dart';
import 'package:al_qamar/pages/calender/widgets/monthly_calender.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocBuilder<AzanBloc, AzanState>(
          builder: (context, state) {
            if (state is CompletedAzanState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.azanTimeList.length,
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: AzanWidget(
                      city: index == 0
                          ? 'najaf'.localize(context)
                          : 'london'.localize(context),
                      azanTime: state.azanTimeList[index],
                    ),
                  ),
                ),
              );
            } else {
              return const SliverToBoxAdapter();
            }
          },
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FourActions(),
          ),
        ),
      ],
    );
  }
}
