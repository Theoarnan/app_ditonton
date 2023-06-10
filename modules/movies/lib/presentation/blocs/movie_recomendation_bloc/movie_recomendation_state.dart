part of 'movie_recomendation_bloc.dart';

abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();
  @override
  List<Object> get props => [];
}

class MoviesRecomendationEmpty extends MovieRecomendationState {}

class MoviesRecomendationLoading extends MovieRecomendationState {}

class MoviesRecomendationError extends MovieRecomendationState {
  final String message;
  const MoviesRecomendationError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieRecomendationHasData extends MovieRecomendationState {
  final List<Movie> resultMovies;
  const MovieRecomendationHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}
