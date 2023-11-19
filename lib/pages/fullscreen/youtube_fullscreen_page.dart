// import 'package:al_qamar/constants/colors.dart';
// import 'package:al_qamar/utils/extensions/duration.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeFullscreenPage extends StatefulWidget {
//   const YoutubeFullscreenPage({
//     super.key,
//     required this.youTubeCtrl,
//     this.youtubeID,
//   });

//   final YoutubePlayerController youTubeCtrl;
//   final String? youtubeID;

//   @override
//   State<YoutubeFullscreenPage> createState() => _YoutubeFullscreenPageState();
// }

// class _YoutubeFullscreenPageState extends State<YoutubeFullscreenPage> {
//   late final YoutubePlayerController _youtubeCtrl;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     _youtubeCtrl = YoutubePlayerController(
//       initialVideoId: widget.youtubeID ?? '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//       ),
//     )..addListener(() {
//         setState(() {});
//         if (_youtubeCtrl.value.position.inSeconds ==
//             _youtubeCtrl.metadata.duration.inSeconds - 1) {
//           _youtubeCtrl.seekTo(const Duration(milliseconds: 0));
//         }
//       });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
//     );
//     _youtubeCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayer(
//       controller: _youtubeCtrl,
//       bottomActions: [
//         const Spacer(),
//         Text.rich(
//           style:
//               Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14),
//           TextSpan(
//             text: _youtubeCtrl.value.position.format(),
//             children: [
//               TextSpan(
//                 text: '/${_youtubeCtrl.metadata.duration.format()}',
//               ),
//             ],
//           ),
//         ),
//         const Spacer(),
//         Directionality(
//           textDirection: TextDirection.ltr,
//           child: SizedBox(
//             width: MediaQuery.sizeOf(context).width / 1.5,
//             child: Slider(
//               min: 0,
//               max: _youtubeCtrl.metadata.duration.inMilliseconds.toDouble(),
//               value: _youtubeCtrl.value.position.inMilliseconds.toDouble(),
//               inactiveColor: AppColors.grey600,
//               activeColor: AppColors.white,
//               onChanged: (value) {
//                 _youtubeCtrl.seekTo(Duration(milliseconds: value.toInt()));
//               },
//             ),
//           ),
//         ),
//         const Spacer(),
//         GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: const Icon(
//             Icons.fullscreen_exit_rounded,
//             color: AppColors.white,
//             size: 40,
//           ),
//         ),
//         const Spacer(),
//       ],
//     );
//   }
// }
