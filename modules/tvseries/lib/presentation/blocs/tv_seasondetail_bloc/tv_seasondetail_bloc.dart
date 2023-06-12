import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_seasondetail_state.dart';

class TvSeasonDetailBloc extends Cubit<TvSeasonDetailState> {
  final GetSeasonDetail _getSeasonDetail;

  TvSeasonDetailBloc(
    this._getSeasonDetail,
  ) : super(TvSeasonDetailEmpty());

  void fetchTvSeasonDetail({
    required int id,
    required int seasonNumber,
  }) async {
    emit(TvSeasonDetailLoading());
    final result = await _getSeasonDetail.execute(id, seasonNumber);
    result.fold(
      (failure) => emit(TvSeasonDetailError(failure.message)),
      (data) => emit(TvSeasonDetailHasData(data)),
    );
  }
}
