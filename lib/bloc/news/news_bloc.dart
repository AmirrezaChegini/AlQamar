import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final IArticelRepository _articelRepository;

  List<Article> articleList = [];
  int page = 0;

  NewsBloc(this._articelRepository) : super(InitNewsState()) {
    on<GetAllArticlesEvent>((event, emit) async {
      if (articleList.isEmpty) {
        emit(LoadingNewsState());
      }
      page++;
      var either = await _articelRepository.getAllArticles(page: page);

      either.fold((l) {
        emit(FailNewsState(l));
      }, (r) {
        articleList.addAll(r);
      });

      emit(CompleteNewsState(articleList));
    });
  }
}
