import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvNotifier({
    required this.getOnTheAirTv,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
