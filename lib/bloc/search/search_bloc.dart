import 'package:al_qamar/bloc/search/search_event.dart';
import 'package:al_qamar/bloc/search/search_state.dart';
import 'package:al_qamar/data/repositories/article_repository.dart';
import 'package:bloc/bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IArticelRepository _articelRepository;

  SearchBloc(this._articelRepository) : super(InitSearchState()) {
    on<SearchArticleEvent>((event, emit) async {
      var either =
          await _articelRepository.searchArticles(searchText: event.searchText);

      either.fold((l) {
        emit(FailSearchState(l));
      }, (r) {
        emit(CompleteSearchState(r));
      });
    });
  }
}
