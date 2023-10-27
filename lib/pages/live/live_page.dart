import 'package:al_qamar/bloc/live/live_bloc.dart';
import 'package:al_qamar/bloc/live/live_event.dart';
import 'package:al_qamar/bloc/live/live_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/live/widgets/audio_stream.dart';
import 'package:al_qamar/pages/live/widgets/live_item.dart';
import 'package:al_qamar/pages/live/widgets/live_tabbar.dart';
import 'package:al_qamar/pages/live/widgets/video_stream.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:al_qamar/widgets/programs.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage>
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: LiveTabbar(tabCtrl: _tabCtrl),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: 5,
                            children: List.generate(
                              state.videoList.length,
                              (index) => LiveItem(
                                onTap: () => setState(() {
                                  videoIndex = index;
                                }),
                                title: state.videoList[index].name,
                                color: videoIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: VideoStream(
                                url: state.videoList[videoIndex].url,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            height: 1,
                            color: AppColors.grey600,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              child: TitleWidget(
                                title: 'programList'.localize(context),
                                showDivider: true,
                                dividerWidth: 90,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state
                                  .videoList[videoIndex].programList.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: Programs(
                                  program: state
                                      .videoList[videoIndex].programList[index],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: List.generate(
                              state.audioList.length,
                              (index) => LiveItem(
                                onTap: () => setState(() {
                                  audioIndex = index;
                                }),
                                title: state.audioList[index].name,
                                color: audioIndex == index
                                    ? AppColors.grey600
                                    : AppColors.transparent,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: AudioStream(
                              url: state.audioList[audioIndex].url,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10,
                            ),
                            height: 1,
                            color: AppColors.grey600,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                              child: TitleWidget(
                                title: 'programList'.localize(context),
                                showDivider: true,
                                dividerWidth: 90,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: state
                                  .audioList[audioIndex].programList.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: Programs(
                                  program: state
                                      .audioList[audioIndex].programList[index],
                                ),
                              ),
                            ),
                          )
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
