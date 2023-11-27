import 'package:al_qamar/bloc/live/live_bloc.dart';
import 'package:al_qamar/bloc/live/live_event.dart';
import 'package:al_qamar/bloc/live/live_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/program.dart';
import 'package:al_qamar/pages/live/widgets/live_item.dart';
import 'package:al_qamar/pages/live/widgets/live_tabbar.dart';
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
    BlocProvider.of<LiveBloc>(context).add(GetLiveEvent());
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'live'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: BlocBuilder<LiveBloc, LiveState>(
        builder: (context, state) {
          if (state is CompleteLiveState) {
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
                            children: List.generate(
                              state.videoList.length,
                              (index) => LiveItem(
                                onTap: () {
                                  setState(() {
                                    videoIndex = index;
                                  });
                                },
                                image: state.videoList[index].image,
                                color: videoIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GroupedListView<Program, DateTime>(
                              elements: state.videoList[videoIndex].programList,
                              groupBy: (e) => DateTime(
                                e.time.year,
                                e.time.month,
                                e.time.day,
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
                                      : DateFormat('dd/MM/yyy').format(time),
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 14),
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
                            children: List.generate(
                              state.audioList.length,
                              (index) => LiveItem(
                                onTap: () {
                                  setState(() {
                                    audioIndex = index;
                                  });
                                },
                                image: state.audioList[index].image,
                                color: audioIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GroupedListView<Program, DateTime>(
                              elements: state.audioList[audioIndex].programList,
                              groupBy: (e) => DateTime(
                                e.time.year,
                                e.time.month,
                                e.time.day,
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
                                      : DateFormat('dd/MM/yyy').format(time),
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 14),
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

          if (state is LoadingLiveState) {
            return const LoadingState();
          }

          if (state is FailLiveState) {
            return Center(
              child: ErrorState(
                onTap: () =>
                    BlocProvider.of<LiveBloc>(context).add(GetLiveEvent()),
                bottomMargin: 0,
                errorMessage: state.errorMessage,
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
