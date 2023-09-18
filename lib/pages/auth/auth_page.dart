import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/header_auth.dart';
import 'package:al_qamar/pages/auth/widgets/login_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/register_widgets.dart';
import 'package:al_qamar/pages/auth/widgets/tabbar_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 6 - 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(AppImages.authBackground),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TabbarAuth(tabCtrl: _tabCtrl),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabCtrl,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: LoginWidgets(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: RegisterWidgets(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const HeaderAuth(),
        ],
      ),
    );
  }
}
