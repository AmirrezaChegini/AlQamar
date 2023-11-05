import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_event.dart';
import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/calender/calender_page.dart';
import 'package:al_qamar/pages/home/home_page.dart';
import 'package:al_qamar/pages/main_wrapper/widgets/bottom_navbar.dart';
import 'package:al_qamar/pages/news/news_page.dart';
import 'package:al_qamar/pages/profile/profile_page.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/appbar_leading.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;
  bool exit = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AzanBloc>(context).add(GetAzanTimeEvent());
    BlocProvider.of<CalenderBloc>(context)
        .add(GetCalenderEvent(DateTime.now().getFormatDate()));
    _tabCtrl = TabController(length: 5, vsync: this, initialIndex: 4);
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState?.closeDrawer();
        } else {
          if (_tabCtrl.index != 4) {
            BlocProvider.of<BottomnavCubit>(context).changeIndex(4);
            _tabCtrl.animateTo(4);
          } else {
            if (exit) {
              SystemNavigator.pop();
            } else {
              exit = true;
              showMessage(
                context: context,
                content: 'exit'.localize(context),
                horizontalMargin: 10,
                verticalMargin: 0,
                isError: false,
              );
              await Future.delayed(
                  const Duration(seconds: 3), () => exit = false);
            }
          }
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavbar(tabController: _tabCtrl),
        backgroundColor: AppColors.grey200,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: MainAppbar(
          leadingWidth: MediaQuery.sizeOf(context).width / 2,
          appbarLeading: const AppbarLeading(),
        ),
        drawer: ProfilePage(tabController: _tabCtrl),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is CompleteLogoutState) {
              _scaffoldKey.currentState?.closeDrawer();
              showMessage(
                context: context,
                content: 'logoutSuccess'.localize(context),
                horizontalMargin: 10,
                verticalMargin: 0,
                isError: false,
              );

              BlocProvider.of<UserBloc>(context).add(GetUserEvent());
            }

            if (state is FailAuthState) {
              showMessage(
                context: context,
                content: state.errorMessage.localize(context),
                horizontalMargin: 10,
                verticalMargin: 0,
              );
            }
          },
          child: TabBarView(
            controller: _tabCtrl,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const CalenderPage(),
              Center(child: Image.asset(AppImages.comingSoon)),
              const SizedBox(),
              const NewsPage(),
              HomePage(tabController: _tabCtrl),
            ],
          ),
        ),
      ),
    );
  }
}
