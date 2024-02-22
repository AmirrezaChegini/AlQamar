import 'package:al_qamar/bloc/search/search_event.dart';
import 'package:al_qamar/bloc/search/search_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IArticelRepository _articelRepository;

  SearchBloc(this._articelRepository) : super(InitSearchState()) {
    on<SearchArticleEvent>((event, emit) async {
      ApiModel<List<Article>, String> either =
          await _articelRepository.searchArticles(searchText: event.searchText);

      either.fold(
        (data) {
          if (data.isEmpty) {
            emit(InitSearchState());
          } else {
            emit(CompleteSearchState(data));
          }
        },
        (error) => emit(FailSearchState(error)),
      );
    });
  }
}
