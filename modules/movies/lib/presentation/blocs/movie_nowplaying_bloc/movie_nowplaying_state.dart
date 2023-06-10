part of 'movie_nowplaying_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();
  @override
  List<Object> get props => [];
}

class MoviesNowPlayingEmpty extends MovieNowPlayingState {}

class MoviesNowPlayingLoading extends MovieNowPlayingState {}

class MoviesNowPlayingError extends MovieNowPlayingState {
  final String message;
  const MoviesNowPlayingError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> resultMovies;
  const MovieNowPlayingHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}
