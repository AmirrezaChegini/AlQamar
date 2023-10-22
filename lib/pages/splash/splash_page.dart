import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/main_wrapper/main_wrapper_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(GetAllDataHomeEvent());
    BlocProvider.of<NewsBloc>(context).add(GetAllNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is CompleteHomeState) {
          Navigator.pushReplacement(
            context,
            fadePageTran(child: const MainWrapperPage()),
          );
        }

        if (state is FailHomeState) {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
              builder: (context) => Container(),
              onClosing: () {},
              backgroundColor: AppColors.red100,
            ),
          );
        }
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.splashBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LoadingState(
              width: MediaQuery.sizeOf(context).width / 1.5,
              height: MediaQuery.sizeOf(context).height / 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
