import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/salavat/salavat_bloc.dart';
import 'package:al_qamar/bloc/search/search_bloc.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/cubit/btn_verify_cubit.dart';
import 'package:al_qamar/cubit/counter_cubit.dart';
import 'package:al_qamar/cubit/localize_cubit.dart';
import 'package:al_qamar/cubit/pdf_cubit.dart';
import 'package:al_qamar/cubit/salavat_cubit.dart';
import 'package:al_qamar/cubit/timer_cubit.dart';
import 'package:al_qamar/data/datasources/article_datasource.dart';
import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/data/datasources/azan_datasource.dart';
import 'package:al_qamar/data/datasources/calender_datasource.dart';
import 'package:al_qamar/data/datasources/salavat_datasource.dart';
import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/data/repositories/auth_repository.dart';
import 'package:al_qamar/data/repositories/azan_repository.dart';
import 'package:al_qamar/data/repositories/calender_repositoy.dart';
import 'package:al_qamar/data/repositories/salavat_repository.dart';
import 'package:al_qamar/data/repositories/user_repository.dart';
import 'package:al_qamar/utils/error_handling/app_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

var locator = GetIt.I;

Future<void> initLocator() async {
  //classes
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'http://192.168.91.2:8000/api/v1',
        connectTimeout: const Duration(seconds: 20),
      ),
    )..interceptors.add(AppInterceptors()),
  );
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions:
            IOSOptions(accessibility: KeychainAccessibility.first_unlock)),
  );
  locator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  //datasources
  locator
      .registerLazySingleton<AzanDatasource>(() => AzanRemote(locator.get()));
  locator.registerLazySingleton<SalavatDatasource>(() => SalavatLocal());
  locator
      .registerLazySingleton<AuthDatasource>(() => AuthRemote(locator.get()));
  locator
      .registerLazySingleton<UserDatasource>(() => UserRemote(locator.get()));
  locator.registerLazySingleton<ArticleDatasource>(
      () => ArticleRemote(locator.get()));
  locator.registerLazySingleton<CalenderDatasource>(
      () => CalenderRemote(locator.get()));

  //repositories
  locator.registerLazySingleton<IAzanRepository>(
      () => AzanRepositoryImpl(locator.get()));
  locator.registerLazySingleton<ISalavatRepository>(
      () => SalavatRepositoryImpl(locator.get()));
  locator.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(locator.get()));
  locator.registerLazySingleton<IUserRepository>(
      () => UserRepositoryImpl(locator.get()));
  locator.registerLazySingleton<IArticelRepository>(
      () => ArticleRepositoryImple(locator.get()));
  locator.registerLazySingleton<ICalenderRepository>(
      () => CalenderRepositoryImpl(locator.get()));

  //cubit
  locator.registerLazySingleton<LocalizeCubit>(() => LocalizeCubit());
  locator.registerLazySingleton<BottomnavCubit>(() => BottomnavCubit());
  locator.registerLazySingleton<CounterCubit>(() => CounterCubit());
  locator.registerLazySingleton<SalavatCubit>(() => SalavatCubit());
  locator.registerLazySingleton<TimerCubit>(() => TimerCubit());
  locator.registerLazySingleton<BtnVerifyCubit>(() => BtnVerifyCubit());
  locator.registerLazySingleton<ArticleCubit>(() => ArticleCubit());
  locator.registerLazySingleton<AudioCubit>(() => AudioCubit(locator.get()));
  locator.registerLazySingleton<PdfCubit>(() => PdfCubit());

  //bloc
  locator.registerLazySingleton<AzanBloc>(() => AzanBloc(locator.get()));
  locator.registerLazySingleton<SalavatBloc>(() => SalavatBloc(locator.get()));
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc(locator.get()));
  locator.registerLazySingleton<UserBloc>(() => UserBloc(locator.get()));
  locator.registerLazySingleton<HomeBloc>(() => HomeBloc(locator.get()));
  locator.registerLazySingleton<NewsBloc>(() => NewsBloc(locator.get()));
  locator.registerLazySingleton<SearchBloc>(() => SearchBloc(locator.get()));
  locator
      .registerLazySingleton<CalenderBloc>(() => CalenderBloc(locator.get()));
}
