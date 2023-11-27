import 'package:al_qamar/models/article.dart';

sealed class OtherArticleState {}

class InitOtherArticleState extends OtherArticleState {}

class LoadingOtherArticleState extends OtherArticleState {}

class CompleteOtherArticleState extends OtherArticleState {
  final List<Article> articleList;
  CompleteOtherArticleState(this.articleList);
}

class FailOtherArticleState extends OtherArticleState {
  final String errorMessage;
  FailOtherArticleState(this.errorMessage);
}
