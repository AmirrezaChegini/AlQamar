import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/account/account_page.dart';
import 'package:al_qamar/pages/home/home_page.dart';
import 'package:al_qamar/pages/main_wrapper/widgets/bottom_navbar.dart';
import 'package:al_qamar/pages/main_wrapper/widgets/main_appbar.dart';
import 'package:al_qamar/pages/news/news_page.dart';
import 'package:flutter/material.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this, initialIndex: 4);
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
    _animCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        tabCtrl: _tabCtrl,
        animCtrl: _animCtrl,
      ),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: const MainAppbar(),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.grey600,
              AppColors.grey200,
              AppColors.grey200,
              AppColors.grey200,
              AppColors.grey200,
              AppColors.grey200,
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabCtrl,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Center(
              child: Text('1'),
            ),
            AccountPage(),
            SizedBox(),
            NewsPage(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}
