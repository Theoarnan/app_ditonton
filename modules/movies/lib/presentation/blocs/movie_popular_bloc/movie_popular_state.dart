part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();
  @override
  List<Object> get props => [];
}

class MoviesPopularEmpty extends MoviePopularState {}

class MoviesPopularLoading extends MoviePopularState {}

class MoviesPopularError extends MoviePopularState {
  final String message;
  const MoviesPopularError(this.message);
  @override
  List<Object> get props => [message];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> resultMovies;
  const MoviePopularHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}
