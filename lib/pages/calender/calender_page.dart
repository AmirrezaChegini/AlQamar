import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: const MainAppbar(),
      body: SafeArea(
        child: Column(
          children: [
            SfHijriDateRangePicker(
              cellBuilder: (context, cellDetails) => Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.blue),
                ),
                child: Text(
                  cellDetails.date.day.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
