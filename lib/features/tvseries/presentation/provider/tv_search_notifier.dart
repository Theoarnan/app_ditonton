import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/search_tv.dart';
import 'package:flutter/material.dart';

class TvSearchNotifier extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  final SearchTv searchTv;
  TvSearchNotifier({required this.searchTv});

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
