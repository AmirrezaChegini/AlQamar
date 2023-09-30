import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/salavat/salavat_bloc.dart';
import 'package:al_qamar/cubit/bottom_nav_cubit.dart';
import 'package:al_qamar/cubit/counter_cubit.dart';
import 'package:al_qamar/cubit/register_cubit.dart';
import 'package:al_qamar/cubit/salavat_cubit.dart';
import 'package:al_qamar/data/datasources/azan_datasource.dart';
import 'package:al_qamar/data/datasources/salavat_datasource.dart';
import 'package:al_qamar/data/repositories/azan_repository.dart';
import 'package:al_qamar/data/repositories/salavat_repository.dart';
import 'package:al_qamar/utils/error_handling/app_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.I;

Future<void> initLocator() async {
  //classes
  locator.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(connectTimeout: const Duration(seconds: 20)))
      ..interceptors.add(AppInterceptors()),
  );

  //datasources
  locator
      .registerLazySingleton<AzanDatasource>(() => AzanRemote(locator.get()));
  locator.registerLazySingleton<SalavatDatasource>(() => SalavatLocal());

  //repositories
  locator.registerLazySingleton<IAzanRepository>(
      () => AzanRepositoryImpl(locator.get()));
  locator.registerLazySingleton<ISalavatRepository>(
      () => SalavatRepositoryImpl(locator.get()));

  //cubit
  locator.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  locator.registerLazySingleton<BottomnavCubit>(() => BottomnavCubit());
  locator.registerLazySingleton<CounterCubit>(() => CounterCubit());
  locator.registerLazySingleton<SalavatCubit>(() => SalavatCubit());

  //bloc
  locator.registerLazySingleton<AzanBloc>(() => AzanBloc(locator.get()));
  locator.registerLazySingleton<SalavatBloc>(() => SalavatBloc(locator.get()));
}
