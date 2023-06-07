import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  final GetSeasonDetail getSeasonDetail;

  SeasonDetailNotifier({required this.getSeasonDetail});

  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;
  RequestState _seasonState = RequestState.empty;
  RequestState get seasonState => _seasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchSeasonDetail({
    required int id,
    required int seasonNumber,
  }) async {
    _seasonState = RequestState.loading;
    notifyListeners();
    final result = await getSeasonDetail.execute(id, seasonNumber);
    result.fold(
      (failure) {
        _message = failure.message;
        _seasonState = RequestState.error;
        notifyListeners();
      },
      (seasionData) {
        _seasonDetail = seasionData;
        _seasonState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
