import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/salavat/salavat_bloc.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/cubit/btn_verify_cubit.dart';
import 'package:al_qamar/cubit/counter_cubit.dart';
import 'package:al_qamar/cubit/salavat_cubit.dart';
import 'package:al_qamar/cubit/timer_cubit.dart';
import 'package:al_qamar/data/datasources/auth_datasource.dart';
import 'package:al_qamar/data/datasources/azan_datasource.dart';
import 'package:al_qamar/data/datasources/salavat_datasource.dart';
import 'package:al_qamar/data/datasources/user_datasource.dart';
import 'package:al_qamar/data/repositories/auth_repository.dart';
import 'package:al_qamar/data/repositories/azan_repository.dart';
import 'package:al_qamar/data/repositories/salavat_repository.dart';
import 'package:al_qamar/data/repositories/user_repository.dart';
import 'package:al_qamar/utils/error_handling/app_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;

Future<void> initLocator() async {
  //classes
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'http://192.168.213.2:8585/api/v1',
        connectTimeout: const Duration(seconds: 20),
      ),
    )..interceptors.add(AppInterceptors()),
  );
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //datasources
  locator
      .registerLazySingleton<AzanDatasource>(() => AzanRemote(locator.get()));
  locator.registerLazySingleton<SalavatDatasource>(() => SalavatLocal());
  locator
      .registerLazySingleton<AuthDatasource>(() => AuthRemote(locator.get()));
  locator
      .registerLazySingleton<UserDatasource>(() => UserRemote(locator.get()));

  //repositories
  locator.registerLazySingleton<IAzanRepository>(
      () => AzanRepositoryImpl(locator.get()));
  locator.registerLazySingleton<ISalavatRepository>(
      () => SalavatRepositoryImpl(locator.get()));
  locator.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(locator.get()));
  locator.registerLazySingleton<IUserRepository>(
      () => UserRepositoryImpl(locator.get()));

  //cubit
  locator.registerLazySingleton<BottomnavCubit>(() => BottomnavCubit());
  locator.registerLazySingleton<CounterCubit>(() => CounterCubit());
  locator.registerLazySingleton<SalavatCubit>(() => SalavatCubit());
  locator.registerLazySingleton<TimerCubit>(() => TimerCubit());
  locator.registerLazySingleton<BtnVerifyCubit>(() => BtnVerifyCubit());

  //bloc
  locator.registerLazySingleton<AzanBloc>(() => AzanBloc(locator.get()));
  locator.registerLazySingleton<SalavatBloc>(() => SalavatBloc(locator.get()));
  locator.registerLazySingleton<AuthBloc>(() => AuthBloc(locator.get()));
  locator.registerLazySingleton<UserBloc>(() => UserBloc(locator.get()));
}
