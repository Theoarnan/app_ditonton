import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Cubit<TvPopularState> {
  final GetPopularTv _getPopularTv;

  TvPopularBloc(
    this._getPopularTv,
  ) : super(TvPopularEmpty());

  void fetchTvPopular() async {
    emit(TvPopularLoading());
    final result = await _getPopularTv.execute();
    result.fold(
      (failure) => emit(TvPopularError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(TvPopularEmpty());
        emit(TvPopularHasData(data));
      },
    );
  }
}
