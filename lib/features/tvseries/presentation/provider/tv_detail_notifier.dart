import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;
  RequestState _tvState = RequestState.empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;
  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
  });

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.loading;
        _tvDetail = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.loaded;
            _tvRecommendations = movies;
          },
        );
        _tvState = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
