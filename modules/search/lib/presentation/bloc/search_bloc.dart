import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTv _searchTv;

  SearchBloc(
    this._searchMovies,
    this._searchTv,
  ) : super(InitSearch()) {
    on<OnQueryChangedMovie>(
      (event, emit) => _onChangedMovie(event, emit),
      transformer: debounce(const Duration(milliseconds: 600)),
    );
    on<OnQueryChangedTv>(
      (event, emit) => _onChangedTv(event, emit),
      transformer: debounce(const Duration(milliseconds: 600)),
    );
  }

  void _onChangedMovie(
    OnQueryChangedMovie event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;
    emit(SearchLoading());
    final result = await _searchMovies.execute(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(SearchEmpty());
        emit(SearchMovieHasData(data));
      },
    );
  }

  void _onChangedTv(
    OnQueryChangedTv event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;
    emit(SearchLoading());
    final result = await _searchTv.execute(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(SearchEmpty());
        emit(SearchTvHasData(data));
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
