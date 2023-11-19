import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeArticlePlayer extends StatefulWidget {
  const YoutubeArticlePlayer({
    super.key,
    this.youtubeID,
  });
  final String? youtubeID;

  @override
  State<YoutubeArticlePlayer> createState() => _YoutubeArticlePlayerState();
}

class _YoutubeArticlePlayerState extends State<YoutubeArticlePlayer>
    with AutomaticKeepAliveClientMixin {
  late final YoutubePlayerController _playerCtrl;

  @override
  void initState() {
    super.initState();
    _playerCtrl = YoutubePlayerController()..loadVideo(widget.youtubeID ?? '');
  }

  @override
  void dispose() {
    _playerCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: _playerCtrl,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


// YoutubePlayer(
//           controller: _youtubeCtrl,
//           onReady: () {
//             _youtubeCtrl.addListener(() {
//               setState(() {});
//               if (_youtubeCtrl.value.position.inSeconds ==
//                   _youtubeCtrl.metadata.duration.inSeconds - 1) {
//                 _youtubeCtrl.seekTo(const Duration(milliseconds: 0));
//               }
//             });
//           },
//           bottomActions: [
//             const Spacer(),
//             Text.rich(
//               style: Theme.of(context)
//                   .textTheme
//                   .labelMedium!
//                   .copyWith(fontSize: 14),
//               TextSpan(
//                 text: _youtubeCtrl.value.position.format(),
//                 children: [
//                   TextSpan(
//                     text: '/${_youtubeCtrl.metadata.duration.format()}',
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Directionality(
//               textDirection: TextDirection.ltr,
//               child: SizedBox(
//                 child: Slider(
//                   min: 0,
//                   max: _youtubeCtrl.metadata.duration.inMilliseconds.toDouble(),
//                   value: _youtubeCtrl.value.position.inMilliseconds.toDouble(),
//                   inactiveColor: AppColors.grey600,
//                   activeColor: AppColors.white,
//                   onChanged: (value) {
//                     _youtubeCtrl.seekTo(Duration(milliseconds: value.toInt()));
//                   },
//                 ),
//               ),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 fadePageTran(
//                   child: YoutubeFullscreenPage(
//                     youTubeCtrl: _youtubeCtrl,
//                     youtubeID: widget.youtubeID,
//                   ),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.fullscreen_rounded,
//                 color: AppColors.white,
//                 size: 40,
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),