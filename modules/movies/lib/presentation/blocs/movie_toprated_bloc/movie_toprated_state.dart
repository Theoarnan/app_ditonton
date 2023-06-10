part of 'movie_toprated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
  @override
  List<Object> get props => [];
}

class MoviesTopRatedEmpty extends MovieTopRatedState {}

class MoviesTopRatedLoading extends MovieTopRatedState {}

class MoviesTopRatedError extends MovieTopRatedState {
  final String message;
  const MoviesTopRatedError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> resultMovies;
  const MovieTopRatedHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}
