import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/utils/get_permission.dart';
import 'package:al_qamar/utils/image_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CameraDialog extends StatelessWidget {
  const CameraDialog({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () async {
              ImagePick.pickPhoto().then((value) {
                  if (value != null) {
                    value.length().then((size) {
                      if (size < 2000000) {
                        BlocProvider.of<UserBloc>(context).add(UpdateUserEvent(
                          id: user.id,
                          firstName: user.firstName,
                          lastName: user.lastName,
                          bio: user.bio,
                          avatar: value,
                        ));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Photo must be less than 2 MB');
                      }
                    });
                  }
                });
            },
            leading: const Icon(Icons.photo_camera_rounded),
            title: Text('camera'.localize(context)),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            onTap: () {
              ImagePick.pickImage().then((value) {
                if (value != null) {
                  value.length().then((size) {
                    if (size < 2000000) {
                      BlocProvider.of<UserBloc>(context).add(UpdateUserEvent(
                        id: user.id,
                        firstName: user.firstName,
                        lastName: user.lastName,
                        bio: user.bio,
                        avatar: value,
                      ));
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Photo must be less than 2 MB');
                    }
                  });
                }
              });
            },
            leading: const Icon(Icons.image_rounded),
            title: Text('gallery'.localize(context)),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
