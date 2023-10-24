import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IArticelRepository _articelRepository;

  HomeBloc(this._articelRepository) : super(InitHomeState()) {
    on<GetAllDataHomeEvent>((event, emit) async {
      // List<Article> articleList = [];
      List<Article> forceArticleList = [];

      emit(LoadingHomeState());
      await Future.delayed(const Duration(seconds: 2));
      var either = await _articelRepository.getAllArticles();
      // var forceEither = await _articelRepository.getForceArticles();

      either.fold((l) {
        emit(FailHomeState(l));
      }, (r) {
        emit(CompleteHomeState(r, forceArticleList));
      });

      // forceEither.fold((l) {
      //   emit(FailHomeState(l));
      // }, (r) {
      //   forceArticleList = r;
      // });
    });
  }
}
