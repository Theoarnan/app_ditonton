import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_toprated_state.dart';

class MovieTopRatedBloc extends Cubit<MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(
    this._getTopRatedMovies,
  ) : super(MoviesTopRatedEmpty());

  void fetchMoviesTopRated() async {
    emit(MoviesTopRatedLoading());
    final result = await _getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(MoviesTopRatedError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(MoviesTopRatedEmpty());
        emit(MovieTopRatedHasData(data));
      },
    );
  }
}
