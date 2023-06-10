import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_nowplaying_state.dart';

class MovieNowPlayingBloc extends Cubit<MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(
    this._getNowPlayingMovies,
  ) : super(MoviesNowPlayingEmpty());

  void fetchMoviesNowPlaying() async {
    emit(MoviesNowPlayingLoading());
    final result = await _getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(MoviesNowPlayingError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(MoviesNowPlayingEmpty());
        emit(MovieNowPlayingHasData(data));
      },
    );
  }
}
