import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;
  TopRatedTvNotifier({
    required this.getTopRatedTv,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (moviesData) {
        _tv = moviesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
