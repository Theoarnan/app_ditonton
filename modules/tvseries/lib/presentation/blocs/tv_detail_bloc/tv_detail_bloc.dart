import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  late TvDetailHasData _tvDetailHasDataState;

  TvDetailBloc(
    this._getTvDetail,
    this._getWatchListStatus,
    this._saveWatchlistTv,
    this._removeWatchlistTv,
  ) : super(TvDetailEmpty()) {
    on<FetchTvDetail>((event, emit) => _fetchTvDetail(event, emit));
    on<AddToWatchlistTv>((event, emit) => _addToWatchlistTv(event, emit));
    on<RemoveFromWatchlistTv>(
      (event, emit) => _removeFromWatchlistTv(event, emit),
    );
  }

  void _fetchTvDetail(
    FetchTvDetail event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(TvDetailLoading());
    try {
      final idTvseries = event.idTvseries;
      final resultDetailTv = await _getTvDetail.execute(idTvseries);
      final resultWatchlistStatus =
          await _getWatchListStatus.execute(idTvseries);
      late final TvDetail tvDetail;
      resultDetailTv.fold(
        (failure) => throw failure,
        (data) => tvDetail = data,
      );
      _tvDetailHasDataState = TvDetailHasData(
        tvDetail: tvDetail,
        isActiveWatchlist: resultWatchlistStatus,
      );
      emit(_tvDetailHasDataState);
    } on Failure catch (failure) {
      emit(TvDetailError(failure.message));
    } on DatabaseException catch (error) {
      emit(TvDetailError(error.message));
    }
  }

  _addToWatchlistTv(
    AddToWatchlistTv event,
    Emitter<TvDetailState> emit,
  ) async {
    final currentTvDetail = _tvDetailHasDataState.tvDetail;
    try {
      late final String saveMessage;
      final result = await _saveWatchlistTv.execute(
        currentTvDetail,
      );
      result.fold(
        (failure) => saveMessage = failure.message,
        (result) => saveMessage = result,
      );
      final resultWatchlistStatus = await _getWatchListStatus.execute(
        currentTvDetail.id,
      );
      _tvDetailHasDataState = _tvDetailHasDataState.changeAttr(
        isActiveWatchlist: resultWatchlistStatus,
        watchlistMessage: saveMessage,
      );
      emit(_tvDetailHasDataState);
    } on DatabaseException catch (e) {
      emit(TvDetailError(e.message));
    }
  }

  _removeFromWatchlistTv(
    RemoveFromWatchlistTv event,
    Emitter<TvDetailState> emit,
  ) async {
    late final String removeMessage;
    final currentTvDetail = _tvDetailHasDataState.tvDetail;
    try {
      final result = await _removeWatchlistTv.execute(
        currentTvDetail,
      );
      result.fold(
        (failure) => removeMessage = failure.message,
        (result) => removeMessage = result,
      );
      final resultWatchlistStatus = await _getWatchListStatus.execute(
        currentTvDetail.id,
      );
      _tvDetailHasDataState = _tvDetailHasDataState.changeAttr(
        isActiveWatchlist: resultWatchlistStatus,
        watchlistMessage: removeMessage,
      );
      emit(_tvDetailHasDataState);
    } on DatabaseException catch (e) {
      emit(TvDetailError(e.message));
    }
  }
}
