import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_event.dart';
import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/calender/calender_page.dart';
import 'package:al_qamar/pages/home/home_page.dart';
import 'package:al_qamar/pages/main_wrapper/widgets/bottom_navbar.dart';
import 'package:al_qamar/pages/news/news_page.dart';
import 'package:al_qamar/pages/profile/profile_page.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AzanBloc>(context).add(GetAzanTimeEvent());
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<HomeBloc>(context).add(GetAllDataHomeEvent());

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
      bottomNavigationBar: BottomNavbar(tabController: _tabCtrl),
      backgroundColor: AppColors.grey200,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: const MainAppbar(),
      drawer: ProfilePage(tabController: _tabCtrl),
      drawerDragStartBehavior: DragStartBehavior.down,
      body: TabBarView(
        controller: _tabCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const CalenderPage(),
          const Center(
            child: Text('اشتراک'),
          ),
          const SizedBox(),
          const NewsPage(),
          HomePage(tabController: _tabCtrl),
        ],
      ),
    );
  }
}
