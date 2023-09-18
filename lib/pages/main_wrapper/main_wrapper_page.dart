import 'package:flutter/material.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();

    _tabCtrl = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabCtrl,
        tabs: const [
          Tab(
            text: '1',
          ),
          Tab(
            text: '2',
          ),
          Tab(
            text: '3',
          ),
          Tab(
            text: '4',
          ),
          Tab(
            text: '5',
          ),
        ],
      ),
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
