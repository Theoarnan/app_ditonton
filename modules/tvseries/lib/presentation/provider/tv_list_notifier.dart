import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class TvListNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  TvListNotifier({
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  RequestState _onTheAirState = RequestState.empty;
  RequestState get onTheAirState => _onTheAirState;
  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;
  RequestState _popularTvState = RequestState.empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;
  RequestState _topRatedTvState = RequestState.empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _onTheAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirState = RequestState.loaded;
        _onTheAirTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.loading;
    notifyListeners();
    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.loading;
    notifyListeners();
    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = RequestState.loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}