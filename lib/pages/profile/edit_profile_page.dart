import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:al_qamar/pages/profile/widgets/header_edit_profile.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _bioCtrl;
  // late final TextEditingController _emailCtrl;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController(text: widget.user.firstName);
    _lastNameCtrl = TextEditingController(text: widget.user.lastName);
    _bioCtrl = TextEditingController(text: widget.user.bio);
    // _emailCtrl = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _bioCtrl.dispose();
    // _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
            .copyWith(top: 54),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is InitUserState) {
              showMessage(
                context: context,
                content: 'noInternetConnection'.localize(context),
                horizontalMargin: 20,
              );
            }

            if (state is CompleteUserState) {
              Navigator.maybePop(context);
            }
          },
          child: Column(
            children: [
              const HeaderEditProfile(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFieldAuth(
                            controller: _firstNameCtrl,
                            hint: 'firstname'.localize(context),
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'enterName'.localize(context);
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFieldAuth(
                            controller: _lastNameCtrl,
                            hint: 'lastname'.localize(context),
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'enterName'.localize(context);
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFieldAuth(
                            controller: _bioCtrl,
                            hint: 'bio'.localize(context),
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.text,
                            validate: (p0) {},
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10),
                        //   child: TextFieldAuth(
                        //     controller: _emailCtrl,
                        //     hint: 'email'.localize(context),
                        //     inputAction: TextInputAction.done,
                        //     inputType: TextInputType.text,
                        //     enabled: false,
                        //     validate: (p0) {},
                        //   ),
                        // ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: BtnAuth(
                            onTap: () {
                              if (_globalKey.currentState!.validate()) {
                                BlocProvider.of<UserBloc>(context).add(
                                  UpdateUserEvent(
                                    id: widget.user.id,
                                    firstName: _firstNameCtrl.text,
                                    lastName: _lastNameCtrl.text,
                                    bio: _bioCtrl.text,
                                  ),
                                );
                              }
                            },
                            title: 'submit'.localize(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
