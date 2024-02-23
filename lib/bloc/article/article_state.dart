import 'package:al_qamar/models/article.dart';

sealed class ArticleState {}

class InitArticleState extends ArticleState {}

class LoadingArticleState extends ArticleState {}

class CompleteArticleState extends ArticleState {
  final Article article;
  CompleteArticleState(this.article);
}

class FailedArticleState extends ArticleState {
  final String errorMessage;
  FailedArticleState(this.errorMessage);
}
