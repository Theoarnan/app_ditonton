import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_ontheair_state.dart';

class TvOnTheAirBloc extends Cubit<TvOnTheAirState> {
  final GetOnTheAirTv _getOnTheAirTv;

  TvOnTheAirBloc(
    this._getOnTheAirTv,
  ) : super(TvOnTheAirEmpty());

  void fetchTvOnTheAir() async {
    emit(TvOnTheAirLoading());
    final result = await _getOnTheAirTv.execute();
    result.fold(
      (failure) => emit(TvOnTheAirError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(TvOnTheAirEmpty());
        emit(TvOnTheAirHasData(data));
      },
    );
  }
}
