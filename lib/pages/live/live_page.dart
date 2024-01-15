import 'package:al_qamar/bloc/live/live_bloc.dart';
import 'package:al_qamar/bloc/live/live_event.dart';
import 'package:al_qamar/bloc/live/live_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/cubit/live_cubit.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/pages/live/widgets/audio_stream.dart';
import 'package:al_qamar/pages/live/widgets/live_item.dart';
import 'package:al_qamar/pages/live/widgets/live_tabbar.dart';
import 'package:al_qamar/pages/live/widgets/video_stream.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

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
  final AudioPlayer _audioPlayer = locator.get();

  void initAudio(String url) {
    _audioPlayer.setAudioSource(
      ProgressiveAudioSource(
        Uri.parse(url),
        tag: const MediaItem(
          id: '1',
          title: 'Broadcasting',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    BlocProvider.of<LiveBloc>(context).add(GetLiveEvent());
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
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
      body: BlocConsumer<LiveBloc, LiveState>(
        listener: (context, state) {
          if (state is CompleteLiveState) {
            initAudio(state.audioList[audioIndex].url);
          }
        },
        builder: (context, state) {
          if (state is CompleteLiveState) {
            return OrientationBuilder(
              builder: (context, orientation) => orientation ==
                      Orientation.portrait
                  ? ListView(
                      children: [
                        Container(
                          margin: CheckDirect.isRTL(context)
                              ? const EdgeInsets.symmetric(vertical: 10)
                                  .copyWith(
                                      right:
                                          MediaQuery.sizeOf(context).width / 2,
                                      left: 10)
                              : const EdgeInsets.symmetric(vertical: 10)
                                  .copyWith(
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
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    spacing: 5,
                                    children: List.generate(
                                      state.videoList.length,
                                      (index) => LiveItem(
                                        onTap: () {
                                          setState(() {
                                            videoIndex = index;
                                          });
                                          BlocProvider.of<LiveCubit>(context)
                                              .changeUrl(state
                                                  .videoList[videoIndex].url);
                                        },
                                        image: state.videoList[index].image,
                                        color: videoIndex == index
                                            ? AppColors.grey600
                                            : AppColors.transparent,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: VideoStream(
                                      url: state.videoList[videoIndex].url,
                                    ),
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //     horizontal: 40,
                                  //     vertical: 10,
                                  //   ),
                                  //   height: 1,
                                  //   color: AppColors.grey600,
                                  // ),
                                  // Align(
                                  //   alignment: AlignmentDirectional.centerStart,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //       horizontal: 40,
                                  //       vertical: 10,
                                  //     ),
                                  //     child: TitleWidget(
                                  //       title: 'programList'.localize(context),
                                  //       showDivider: true,
                                  //       dividerWidth: 90,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   child: ListView.builder(
                                  //     itemCount: state.videoList[videoIndex].programList
                                  //                 .length <
                                  //             10
                                  //         ? state
                                  //             .videoList[videoIndex].programList.length
                                  //         : 10,
                                  //     itemBuilder: (context, index) => Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 40, vertical: 10),
                                  //       child: Programs(
                                  //         program: state
                                  //             .videoList[videoIndex].programList[index],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    spacing: 5,
                                    children: List.generate(
                                      state.audioList.length,
                                      (index) => LiveItem(
                                        onTap: () {
                                          setState(() {
                                            audioIndex = index;
                                          });
                                          initAudio(
                                              state.audioList[audioIndex].url);
                                        },
                                        image: state.audioList[index].image,
                                        color: audioIndex == index
                                            ? AppColors.grey600
                                            : AppColors.transparent,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: AudioStream(),
                                  ),
                                  // Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //     horizontal: 40,
                                  //     vertical: 10,
                                  //   ),
                                  //   height: 1,
                                  //   color: AppColors.grey600,
                                  // ),
                                  // Align(
                                  //   alignment: AlignmentDirectional.centerStart,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //       horizontal: 40,
                                  //       vertical: 10,
                                  //     ),
                                  //     child: TitleWidget(
                                  //       title: 'programList'.localize(context),
                                  //       showDivider: true,
                                  //       dividerWidth: 90,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Expanded(
                                  //   child: ListView.builder(
                                  //     itemCount: state.audioList[audioIndex].programList
                                  //                 .length <
                                  //             10
                                  //         ? state
                                  //             .audioList[audioIndex].programList.length
                                  //         : 10,
                                  //     itemBuilder: (context, index) => Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 40, vertical: 10),
                                  //       child: Programs(
                                  //         program: state
                                  //             .audioList[audioIndex].programList[index],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : VideoStream(
                      url: state.videoList[videoIndex].url,
                    ),
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
