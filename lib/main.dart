import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/salavat/salavat_bloc.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/config/theme.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/cubit/btn_verify_cubit.dart';
import 'package:al_qamar/cubit/counter_cubit.dart';
import 'package:al_qamar/cubit/salavat_cubit.dart';
import 'package:al_qamar/cubit/timer_cubit.dart';
import 'package:al_qamar/db.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/pages/main_wrapper/main_wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initDB();
  await initLocator();
  initializeDateFormatting().then((value) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator.get<BottomnavCubit>()),
        BlocProvider(create: (context) => locator.get<CounterCubit>()),
        BlocProvider(create: (context) => locator.get<SalavatCubit>()),
        BlocProvider(create: (context) => locator.get<TimerCubit>()),
        BlocProvider(create: (context) => locator.get<BtnVerifyCubit>()),
        BlocProvider(create: (context) => locator.get<AzanBloc>()),
        BlocProvider(create: (context) => locator.get<SalavatBloc>()),
        BlocProvider(create: (context) => locator.get<AuthBloc>()),
        BlocProvider(create: (context) => locator.get<UserBloc>()),
        BlocProvider(create: (context) => locator.get<HomeBloc>()),
        BlocProvider(create: (context) => locator.get<NewsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        locale: const Locale('ar'),
        home: const MainWrapperPage(),
      ),
    );
  }
}
