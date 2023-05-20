import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier({
    required this.getTopRatedTv,
  });

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
