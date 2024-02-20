import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IArticelRepository _articelRepository;

  HomeBloc(this._articelRepository) : super(InitHomeState()) {
    on<GetHomeEvent>((event, emit) async {
      emit(LoadingHomeState());
      List<Article> lastArticleList = [];
      List<Article> forceArticleList = [];
      String errorMessage = '';

      ApiModel<List<Article>, String> lastArticleEither =
          await _articelRepository.getLastArticles();
      ApiModel<List<Article>, String> forceArticleEither =
          await _articelRepository.getForceArticles();

      lastArticleEither.fold(
        (data) => lastArticleList = data,
        (error) => errorMessage = error,
      );

      forceArticleEither.fold(
        (data) => forceArticleList = data,
        (error) => errorMessage = error,
      );

      if (lastArticleList.isNotEmpty || forceArticleList.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 2), () {
          emit(CompleteHomeState(lastArticleList, forceArticleList));
        });
      } else {
        emit(FailHomeState(errorMessage));
      }
    });
  }
}
