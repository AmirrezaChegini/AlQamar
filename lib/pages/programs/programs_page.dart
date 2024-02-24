import 'package:al_qamar/bloc/program/program_bloc.dart';
import 'package:al_qamar/bloc/program/program_event.dart';
import 'package:al_qamar/bloc/program/program_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/models/program.dart';
import 'package:al_qamar/pages/live/widgets/live_item.dart';
import 'package:al_qamar/pages/live/widgets/live_tabbar.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:al_qamar/widgets/programs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  int videoIndex = 0;
  int audioIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProgramBloc>(context).add(GetProgramEvent());
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        title: 'programs'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: BlocBuilder<ProgramBloc, ProgramState>(
        builder: (context, state) {
          if (state is CompleteProgramState) {
            return ListView(
              children: [
                Container(
                  margin: CheckDirect.isRTL(context)
                      ? const EdgeInsets.symmetric(vertical: 10).copyWith(
                          right: MediaQuery.sizeOf(context).width / 2, left: 10)
                      : const EdgeInsets.symmetric(vertical: 10).copyWith(
                          right: 10,
                          left: MediaQuery.sizeOf(context).width / 2,
                        ),
                  child: LiveTabbar(tabCtrl: _tabCtrl),
                ),
                SizedBox(
                  height: 800,
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: 5,
                            runSpacing: 5,
                            children: List.generate(
                              state.videoProgramList.length,
                              (index) => LiveItem(
                                onTap: () {
                                  setState(() {
                                    videoIndex = index;
                                  });
                                },
                                live: state.videoProgramList[index].live,
                                color: videoIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GroupedListView<Program, DateTime>(
                              elements:
                                  state.videoProgramList[videoIndex].program,
                              groupBy: (e) => DateTime(
                                e.date.year,
                                e.date.month,
                                e.date.day,
                              ),
                              order: GroupedListOrder.ASC,
                              itemBuilder: (context, program) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15)
                                        .copyWith(bottom: 10),
                                child: Programs(program: program),
                              ),
                              groupSeparatorBuilder: (time) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(60),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      AppColors.red.withOpacity(0.4),
                                      AppColors.grey200,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  CheckDirect.isRTL(context)
                                      ? '${HijriCalendar.fromDate(time)}'
                                          .toArabic()
                                      : DateFormat('dd/MM/yyy')
                                          .format(time)
                                          .toArabic(),
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: Fontsize.large),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            runSpacing: 5,
                            children: List.generate(
                              state.audioProgramList.length,
                              (index) => LiveItem(
                                onTap: () {
                                  setState(() {
                                    audioIndex = index;
                                  });
                                },
                                live: state.audioProgramList[index].live,
                                color: audioIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (state.audioProgramList.isNotEmpty)
                            Expanded(
                              child: GroupedListView<Program, DateTime>(
                                elements:
                                    state.audioProgramList[audioIndex].program,
                                groupBy: (e) => DateTime(
                                  e.date.year,
                                  e.date.month,
                                  e.date.day,
                                ),
                                itemBuilder: (context, program) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15)
                                          .copyWith(bottom: 10),
                                  child: Programs(program: program),
                                ),
                                groupSeparatorBuilder: (time) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(60),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.red.withOpacity(0.4),
                                        AppColors.grey200,
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    CheckDirect.isRTL(context)
                                        ? '${HijriCalendar.fromDate(time)}'
                                            .toArabic()
                                        : DateFormat('dd/MM/yyy')
                                            .format(time)
                                            .toArabic(),
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: Fontsize.large),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is LoadingProgramState) {
            return const LoadingState();
          }

          if (state is FailedProgramState) {
            return Center(
              child: ErrorState(
                onTap: () => BlocProvider.of<ProgramBloc>(context)
                    .add(GetProgramEvent()),
                bottomMargin: 0,
                errorMessage: state.errorMessage,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
