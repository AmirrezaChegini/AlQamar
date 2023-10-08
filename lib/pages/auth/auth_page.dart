import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/register_cubit.dart';
import 'package:al_qamar/pages/auth/widgets/header_auth.dart';
import 'package:al_qamar/pages/auth/widgets/login_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/otp_widget.dart';
import 'package:al_qamar/pages/auth/widgets/register_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/tabbar_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();

    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: BlocBuilder<RegisterCubit, bool>(
                    builder: (context, state) =>
                        state ? const OtpWidget() : const RegisterWidgets(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: LoginWidgets(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
