import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_toprated_state.dart';

class TvTopRatedBloc extends Cubit<TvTopRatedState> {
  final GetTopRatedTv _getTopRatedTv;

  TvTopRatedBloc(
    this._getTopRatedTv,
  ) : super(TvTopRatedEmpty());

  void fetchTvTopRated() async {
    emit(TvTopRatedLoading());
    final result = await _getTopRatedTv.execute();
    result.fold(
      (failure) => emit(TvTopRatedError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(TvTopRatedEmpty());
        emit(TvTopRatedHasData(data));
      },
    );
  }
}
