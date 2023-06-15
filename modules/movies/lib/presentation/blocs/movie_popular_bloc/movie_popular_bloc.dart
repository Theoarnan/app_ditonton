import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_popular_state.dart';

class MoviePopularBloc extends Cubit<MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(
    this._getPopularMovies,
  ) : super(MoviesPopularEmpty());

  void fetchMoviesPopular() async {
    emit(MoviesPopularLoading());
    final result = await _getPopularMovies.execute();
    result.fold(
      (failure) => emit(MoviesPopularError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(MoviesPopularEmpty());
        emit(MoviePopularHasData(data));
      },
    );
  }
}
