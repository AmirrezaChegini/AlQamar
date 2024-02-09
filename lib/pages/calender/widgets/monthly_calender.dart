import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/cubit/calender_cubit.dart';
import 'package:al_qamar/pages/calender/widgets/cell_builder.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthlyCalender extends StatefulWidget {
  const MonthlyCalender({
    super.key,
  });

  @override
  State<MonthlyCalender> createState() => _MonthlyCalenderState();
}

class _MonthlyCalenderState extends State<MonthlyCalender> {
  final HijriDatePickerController _hijriCtrl = HijriDatePickerController();

  @override
  void dispose() {
    _hijriCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'previousMonth'.localize(context),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: Fontsize.large),
                  ),
                  BlocBuilder<CalenderCubit, DateTime>(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.getHijriMonth()} - ${state.getHijriYear()}',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                        Text(
                          '${state.getGeregorianMonth()} - ${state.getNextGeregorianMonth()}  - ${state.year}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 150,
                          height: 1,
                          color: AppColors.blue,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'nextMonth'.localize(context),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: Fontsize.large),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: SfHijriDateRangePicker(
                controller: _hijriCtrl,
                headerHeight: 0,
                onViewChanged: (hijriDatePickerViewChangedArgs) {
                  BlocProvider.of<CalenderCubit>(context)
                      .changeDatetime(_hijriCtrl.displayDate!.toDateTime());
                },
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  BlocProvider.of<CalenderBloc>(context).add(GetCalenderEvent(
                      _hijriCtrl.selectedDate!.toDateTime().getFormatDate()));
                },
                selectionColor: AppColors.transparent,
                cellBuilder: (context, cellDetails) {
                  if (cellDetails.date == _hijriCtrl.selectedDate) {
                    return Cellbuilder(
                      date: cellDetails,
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                    );
                  } else if (DateFormat('yyyy-MM-dd')
                          .format(cellDetails.date.toDateTime()) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                    return Cellbuilder(
                      date: cellDetails,
                      backgroundColor: AppColors.blue.withOpacity(0.1),
                      foregroundColor: AppColors.blue,
                    );
                  } else {
                    return Cellbuilder(
                      date: cellDetails,
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
