import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/main_wrapper/widgets/bottom_navbar.dart';
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

    _tabCtrl = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavbar(tabCtrl: _tabCtrl),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          Center(
            child: Text('1'),
          ),
          Center(
            child: Text('2'),
          ),
          Center(
            child: Text('3'),
          ),
          Center(
            child: Text('4'),
          ),
          Center(
            child: Text('5'),
          ),
        ],
      ),
    );
  }
}
