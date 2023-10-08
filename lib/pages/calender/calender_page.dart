import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_event.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/pages/calender/widgets/four_actions.dart';
import 'package:al_qamar/pages/calender/widgets/monthly_calender.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({
    super.key,
  });

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<AzanBloc>(context).add(GetAzanTimeEvent());
  }

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
                      city: index == 0 ? 'نجف' : 'لندن',
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
