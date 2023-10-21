import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/utils/anim/animated_icon.dart';
import 'package:flutter/material.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      selected: false,
      tileColor: AppColors.white,
      selectedTileColor: AppColors.red100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      leading: SizedBox(
        width: MediaQuery.sizeOf(context).width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'صوت ${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16),
            ),
            // Text(
            //   '01:22:32',
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleMedium!
            //       .copyWith(fontSize: 13),
            // ),
          ],
        ),
      ),
      trailing: const IconAnimated(
        icon: AnimatedIcons.play_pause,
        state: false,
      ),
    );
  }
}
