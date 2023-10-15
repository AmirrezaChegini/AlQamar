import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/timer_cubit.dart';
import 'package:al_qamar/pages/auth/widgets/header_auth.dart';
import 'package:al_qamar/pages/auth/widgets/login_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/otp_widget.dart';
import 'package:al_qamar/pages/auth/widgets/register_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/tabbar_auth.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _passwordCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    _firstNameCtrl = TextEditingController(text: 'Amirreza');
    _lastNameCtrl = TextEditingController(text: 'Chegini');
    _emailCtrl = TextEditingController(text: 'amirreza@gmail.com');
    _passwordCtrl = TextEditingController(text: 'amirreza1324');
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
            .copyWith(top: 40),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: AssetImage(AppImages.authBackground),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          children: [
            const HeaderAuth(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: TabbarAuth(
                tabCtrl: _tabCtrl,
              ),
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is FailAuthState) {
                  showMessage(context: context, content: state.errorMessage);
                }

                if (state is FailVerifyState) {
                  showMessage(context: context, content: state.errorMessage);
                }

                if (state is CompleteRegisterState) {
                  showMessage(context: context, content: state.message);
                }

                if (state is CompleteResendCodeState) {
                  showMessage(context: context, content: state.message);
                }

                if (state is CompleteVerifyState) {
                  BlocProvider.of<TimerCubit>(context).cancel();
                  BlocProvider.of<UserBloc>(context).add(
                      CreateUserEvent(_firstNameCtrl.text, _lastNameCtrl.text));
                  Navigator.pop(context);
                }

                if (state is CompleteLoginState) {
                  BlocProvider.of<UserBloc>(context).add(GetUserEvent());
                  Navigator.pop(context);
                }
              },
              builder: (context, state) => Expanded(
                child: TabBarView(
                  controller: _tabCtrl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: state is CompleteRegisterState ||
                              state is FailVerifyState ||
                              state is CompleteResendCodeState ||
                              state is LoadingVerifyState
                          ? OtpWidget(emailCtrl: _emailCtrl)
                          : RegisterWidgets(
                              firstNameCtrl: _firstNameCtrl,
                              lastNameCtrl: _lastNameCtrl,
                              emailCtrl: _emailCtrl,
                              passwordCtrl: _passwordCtrl,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: LoginWidgets(
                        emailCtrl: _emailCtrl,
                        passwordCtrl: _passwordCtrl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
