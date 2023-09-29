import 'package:al_qamar/bloc/salavat/salavat_bloc.dart';
import 'package:al_qamar/cubit/bottom_nav_cubit.dart';
import 'package:al_qamar/cubit/counter_cubit.dart';
import 'package:al_qamar/cubit/register_cubit.dart';
import 'package:al_qamar/cubit/salavat_cubit.dart';
import 'package:al_qamar/data/datasources/salavat_datasource.dart';
import 'package:al_qamar/data/repositories/salavat_repository.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.I;

Future<void> initLocator() async {
  //datasources
  locator.registerLazySingleton<SalavatDatasource>(() => SalavatLocal());

  //repositories
  locator.registerLazySingleton<ISalavatRepository>(
      () => SalavatRepositoryImpl(locator.get()));

  //cubit
  locator.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  locator.registerLazySingleton<BottomnavCubit>(() => BottomnavCubit());
  locator.registerLazySingleton<CounterCubit>(() => CounterCubit());
  locator.registerLazySingleton<SalavatCubit>(() => SalavatCubit());

  //bloc
  locator.registerLazySingleton<SalavatBloc>(() => SalavatBloc(locator.get()));
}
