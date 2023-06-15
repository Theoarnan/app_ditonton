import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  late MovieDetailHasData _movieDetailHasDataState;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getWatchListStatus,
    this._saveWatchlistMovie,
    this._removeWatchlistMovie,
  ) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>((event, emit) => _fetchMovieDetail(event, emit));
    on<AddToWatchlistMovie>((event, emit) => _addToWatchlistMovie(event, emit));
    on<RemoveFromWatchlistMovie>(
      (event, emit) => _removeFromWatchlistMovie(event, emit),
    );
  }

  void _fetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    try {
      final idMovie = event.idMovie;
      final resultDetailMovie = await _getMovieDetail.execute(idMovie);
      final resultWatchlistStatus = await _getWatchListStatus.execute(idMovie);
      late final MovieDetail movieDetail;
      resultDetailMovie.fold(
        (failure) => throw failure,
        (data) => movieDetail = data,
      );
      _movieDetailHasDataState = MovieDetailHasData(
        movieDetail: movieDetail,
        isActiveWatchlist: resultWatchlistStatus,
      );
      emit(_movieDetailHasDataState);
    } on Failure catch (failure) {
      emit(MovieDetailError(failure.message));
    } on DatabaseException catch (error) {
      emit(MovieDetailError(error.message));
    }
  }

  _addToWatchlistMovie(
    AddToWatchlistMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    late final String saveMessage;
    final currentMovieDetail = _movieDetailHasDataState.movieDetail;
    try {
      final result = await _saveWatchlistMovie.execute(
        currentMovieDetail,
      );
      result.fold(
        (failure) => saveMessage = failure.message,
        (result) => saveMessage = result,
      );
      final resultWatchlistStatus = await _getWatchListStatus.execute(
        currentMovieDetail.id,
      );
      _movieDetailHasDataState = _movieDetailHasDataState.changeAttr(
        isActiveWatchlist: resultWatchlistStatus,
        watchlistMessage: saveMessage,
      );
      emit(_movieDetailHasDataState);
    } on DatabaseException catch (e) {
      emit(MovieDetailError(e.message));
    }
  }

  _removeFromWatchlistMovie(
    RemoveFromWatchlistMovie event,
    Emitter<MovieDetailState> emit,
  ) async {
    late final String removeMessage;
    final currentMovieDetail = _movieDetailHasDataState.movieDetail;
    try {
      final result = await _removeWatchlistMovie.execute(
        currentMovieDetail,
      );
      result.fold(
        (failure) => removeMessage = failure.message,
        (result) => removeMessage = result,
      );
      final resultWatchlistStatus = await _getWatchListStatus.execute(
        currentMovieDetail.id,
      );
      _movieDetailHasDataState = _movieDetailHasDataState.changeAttr(
        isActiveWatchlist: resultWatchlistStatus,
        watchlistMessage: removeMessage,
      );
      emit(_movieDetailHasDataState);
    } on DatabaseException catch (e) {
      emit(MovieDetailError(e.message));
    }
  }
}
