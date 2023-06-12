import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_recomendation_state.dart';

class MovieRecomendationBloc extends Cubit<MovieRecomendationState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecomendationBloc(
    this._getMovieRecommendations,
  ) : super(MoviesRecomendationEmpty());

  void fetchMoviesRecomendation(int idMovie) async {
    emit(MoviesRecomendationLoading());
    final result = await _getMovieRecommendations.execute(idMovie);
    result.fold(
      (failure) => emit(MoviesRecomendationError(failure.message)),
      (data) {
        if (data.isEmpty) return emit(MoviesRecomendationEmpty());
        emit(MovieRecomendationHasData(data));
      },
    );
  }
}
