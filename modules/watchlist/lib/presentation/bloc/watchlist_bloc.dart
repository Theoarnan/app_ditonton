import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchlistTv _getWatchlistTv;

  WatchlistBloc(
    this._getWatchlistMovies,
    this._getWatchlistTv,
  ) : super(InitWatchlist()) {
    on<FetchWatchlistMovies>(
      (event, emit) => _fetchWatchlistMovie(event, emit),
    );
    on<FetchWatchlistTv>((event, emit) => _fetchWatchlistTv(event, emit));
  }

  void _fetchWatchlistMovie(
    FetchWatchlistMovies event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    final result = await _getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(WatchlistError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(WatchlistEmpty());
        emit(WatchlistMovieHasData(data));
      },
    );
  }

  void _fetchWatchlistTv(
    FetchWatchlistTv event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    final result = await _getWatchlistTv.execute();
    result.fold(
      (failure) => emit(WatchlistError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(WatchlistEmpty());
        emit(WatchlistTvHasData(data));
      },
    );
  }
}
