import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/localize_cubit.dart';
import 'package:al_qamar/pages/main_wrapper/main_wrapper_page.dart';
import 'package:al_qamar/widgets/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/error_state.dart';
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
    callApis();
  }

  void callApis() {
    BlocProvider.of<LocalizeCubit>(context).getLang();
    BlocProvider.of<HomeBloc>(context).add(GetHomeEvent());
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoadingHomeState) {
            Navigator.maybePop(context);
          }

          if (state is CompleteHomeState) {
            Navigator.pushReplacement(
              context,
              fadePageTran(child: const MainWrapperPage()),
            );
          }

          if (state is FailHomeState) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 1,
                minChildSize: 0.3,
                expand: false,
                builder: (context, scrollController) => ErrorState(
                  errorMessage: state.errorMessage,
                  onTap: callApis,
                  height: 150,
                  width: 150,
                  bottomMargin: 0,
                ),
              ),
            );
          }
        },
        child: DecoratedBox(
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
