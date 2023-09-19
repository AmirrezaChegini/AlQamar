import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/account/account_page.dart';
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
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    _tabCtrl = TabController(length: 5, vsync: this, initialIndex: 4);
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(tabCtrl: _tabCtrl),
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
            Center(
              child: Text('3'),
            ),
            NewsPage(),
            Center(
              child: Text('5'),
            ),
          ],
        ),
      ),
    );
  }
}
