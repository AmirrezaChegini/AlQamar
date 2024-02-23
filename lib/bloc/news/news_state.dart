import 'package:al_qamar/models/article.dart';

sealed class NewsState {}

class InitNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class EmptyNewsState extends NewsState {}

class CompleteNewsState extends NewsState {
  final List<Article> articleList;
  CompleteNewsState(this.articleList);
}

class FailNewsState extends NewsState {
  final String errorMessage;
  FailNewsState(this.errorMessage);
}
