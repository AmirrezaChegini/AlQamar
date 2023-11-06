import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/fullscreen/youtube_fullscreen_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/extensions/duration.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late final YoutubePlayerController _youtubeCtrl;

  @override
  void initState() {
    super.initState();
    _youtubeCtrl = YoutubePlayerController(
      initialVideoId: widget.youtubeID ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    )..addListener(() {
        setState(() {});
        if (_youtubeCtrl.value.position.inSeconds ==
            _youtubeCtrl.metadata.duration.inSeconds - 1) {
          _youtubeCtrl.seekTo(const Duration(milliseconds: 0));
        }
      });
  }

  @override
  void dispose() {
    _youtubeCtrl.dispose();
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
          controller: _youtubeCtrl,
          bottomActions: [
            const Spacer(),
            Text.rich(
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 14),
              TextSpan(
                text: _youtubeCtrl.value.position.format(),
                children: [
                  TextSpan(
                    text: '/${_youtubeCtrl.metadata.duration.format()}',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                child: Slider(
                  min: 0,
                  max: _youtubeCtrl.metadata.duration.inMilliseconds.toDouble(),
                  value: _youtubeCtrl.value.position.inMilliseconds.toDouble(),
                  inactiveColor: AppColors.grey600,
                  activeColor: AppColors.white,
                  onChanged: (value) {
                    _youtubeCtrl.seekTo(Duration(milliseconds: value.toInt()));
                  },
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                fadePageTran(
                  child: YoutubeFullscreenPage(
                    youTubeCtrl: _youtubeCtrl,
                    youtubeID: widget.youtubeID,
                  ),
                ),
              ),
              child: const Icon(
                Icons.fullscreen_rounded,
                color: AppColors.white,
                size: 40,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
