import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_recomendation_state.dart';

class TvRecomendationBloc extends Cubit<TvRecomendationState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecomendationBloc(
    this._getTvRecommendations,
  ) : super(TvRecomendationEmpty());

  void fetchTvRecomendation(int idTvseries) async {
    emit(TvRecomendationLoading());
    final result = await _getTvRecommendations.execute(idTvseries);
    result.fold(
      (failure) => emit(TvRecomendationError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(TvRecomendationEmpty());
        emit(TvRecomendationHasData(data));
      },
    );
  }
}
