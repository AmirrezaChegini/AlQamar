import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IArticelRepository _articelRepository;

  HomeBloc(this._articelRepository) : super(InitHomeState()) {
    on<GetHomeEvent>((event, emit) async {
      emit(LoadingHomeState());
      List<Article> lastArticleList = [];
      List<Article> forceArticleList = [];
      String errorMessage = '';

      var lastArticleEither = await _articelRepository.getLastArticles();
      var forceArticleEither = await _articelRepository.getForceArticles();

      lastArticleEither.fold((l) {
        errorMessage = l;
      }, (r) {
        lastArticleList = r;
      });

      forceArticleEither.fold((l) {
        errorMessage = l;
      }, (r) {
        forceArticleList = r;
      });

      if (lastArticleList.isNotEmpty || forceArticleList.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 4), () {
          emit(CompleteHomeState(lastArticleList, forceArticleList));
        });
      } else {
        emit(FailHomeState(errorMessage));
      }
    });
  }
}
