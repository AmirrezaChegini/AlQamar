import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/auth/widgets/header_auth.dart';
import 'package:al_qamar/pages/auth/widgets/login_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/register_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/tabbar_auth.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _passwordCtrl;
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this, initialIndex: 1);
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _tabCtrl.dispose();
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
        child: Column(
          children: [
            const HeaderAuth(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: TabbarAuth(
                tabCtrl: _tabCtrl,
              ),
            ),
            Expanded(
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is FailedAuthState) {
                    showMessage(
                      context: context,
                      content: state.errorMessage,
                    );
                  }

                  if (state is CompleteAuthState) {
                    BlocProvider.of<UserBloc>(context)
                        .add(SetUserEvent(state.user));
                    Navigator.maybePop(context);
                  }
                },
                child: TabBarView(
                  controller: _tabCtrl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      child: RegisterWidgets(
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
