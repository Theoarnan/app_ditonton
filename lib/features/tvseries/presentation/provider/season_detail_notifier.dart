import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_season_detail.dart';
import 'package:flutter/material.dart';

class SeasonDetailNotifier extends ChangeNotifier {
  late SeasonDetail _seasonDetail;
  SeasonDetail get seasonDetail => _seasonDetail;
  RequestState _seasonState = RequestState.empty;
  RequestState get seasonState => _seasonState;

  String _message = '';
  String get message => _message;

  final GetSeasonDetail getSeasonDetail;
  SeasonDetailNotifier({required this.getSeasonDetail});

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
