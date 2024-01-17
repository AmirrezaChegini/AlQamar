import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:bloc/bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final IArticelRepository _articelRepository;

  List<Article> articleList = [];

  NewsBloc(this._articelRepository) : super(InitNewsState()) {
    on<GetAllArticlesEvent>((event, emit) async {
      emit(LoadingNewsState());
      var either = await _articelRepository.getArticleByCategory(
          categoryId: event.categoryID);

      either.fold((l) {
        emit(FailNewsState(l));
      }, (r) {
        articleList = r;
        emit(CompleteNewsState(r));
      });
    });
  }
}
