import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final IArticelRepository _articelRepository;

  List<Article> articleList = [];

  NewsBloc(this._articelRepository) : super(InitNewsState()) {
    on<GetArticleByCategoryEVent>((event, emit) async {
      if (event.page == 1) {
        emit(LoadingNewsState());
      }
      ApiModel<List<Article>, String> either =
          await _articelRepository.getArticleByCategory(
        categoryId: event.categoryID,
        page: event.page,
      );

      either.fold(
        (data) {
          if (event.page == 1) {
            articleList = data;
          } else {
            articleList.addAll(data);
          }

          if (articleList.isEmpty) {
            emit(EmptyNewsState());
          } else {
            emit(CompleteNewsState(articleList));
          }
        },
        (error) => emit(FailNewsState(error)),
      );
    });

    on<GetAllArticlesEvent>((event, emit) async {
      if (event.page == 1) {
        emit(LoadingNewsState());
      }
      ApiModel<List<Article>, String> either =
          await _articelRepository.getAllArticles(page: event.page);

      either.fold(
        (data) {
          if (event.page == 1) {
            articleList = data;
          } else {
            articleList.addAll(data);
          }

          if (articleList.isEmpty) {
            emit(EmptyNewsState());
          } else {
            emit(CompleteNewsState(articleList));
          }
        },
        (error) => emit(FailNewsState(error)),
      );
    });
  }
}
