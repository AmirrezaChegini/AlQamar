import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/other_article/other_article_event.dart';
import 'package:al_qamar/bloc/other_article/other_article_state.dart';
import 'package:al_qamar/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherArticleBloc extends Bloc<OtherArticleEvent, OtherArticleState> {
  final NewsBloc _newsBloc;

  OtherArticleBloc(this._newsBloc) : super(InitOtherArticleState()) {
    on<GetOtherArticleEvent>((event, emit) async {
      emit(LoadingOtherArticleState());
      await Future.delayed(const Duration(seconds: 1));
      List<Article> articleList = _newsBloc.articleList;
      articleList.shuffle();
      emit(CompleteOtherArticleState(articleList));
    });

    on<InitOtherArticleEvent>((event, emit) async {
      emit(InitOtherArticleState());
    });
  }
}
