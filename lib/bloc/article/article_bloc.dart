import 'package:al_qamar/bloc/article/article_event.dart';
import 'package:al_qamar/bloc/article/article_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final IArticelRepository _repository;

  ArticleBloc(this._repository) : super(InitArticleState()) {
    on<GetArticleEvent>((event, emit) async {
      emit(LoadingArticleState());

      ApiModel<Article, String> either =
          await _repository.getArticle(articleID: event.articleID);

      either.fold(
        (data) => emit(CompleteArticleState(data)),
        (error) => emit(FailedArticleState(error)),
      );
    });
  }
}
