part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();
  @override
  List<Object> get props => [];
}

class InitWatchlist extends WatchlistState {}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;
  const WatchlistError(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistState {
  final List<Movie> resultMovies;
  const WatchlistMovieHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}

class WatchlistTvHasData extends WatchlistState {
  final List<Tv> resultTv;
  const WatchlistTvHasData(this.resultTv);
  @override
  List<Object> get props => [resultTv];
}
