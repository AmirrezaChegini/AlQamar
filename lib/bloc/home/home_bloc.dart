import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/force_article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IArticelRepository _articelRepository;

  HomeBloc(this._articelRepository) : super(InitHomeState()) {
    on<GetHomeEvent>((event, emit) async {
      emit(LoadingHomeState());

      List<Article> articleList = [];
      List<ForceArticle> forceArticleList = [];
      String errorMessage = '';

      ApiModel<List<Article>, String> articleEither =
          await _articelRepository.getAllArticles(page: 1);

      articleEither.fold(
        (data) => articleList = data,
        (error) => errorMessage = error,
      );

      ApiModel<List<ForceArticle>, String> forceArticleEither =
          await _articelRepository.getForceArticles();

      forceArticleEither.fold(
        (data) => forceArticleList = data,
        (error) => errorMessage = error,
      );

      if (articleList.isNotEmpty) {
        await Future.delayed(
          const Duration(seconds: 2),
          () {
            emit(CompleteHomeState(articleList, forceArticleList));
          },
        );
      } else {
        emit(FailHomeState(errorMessage));
      }
    });
  }
}
