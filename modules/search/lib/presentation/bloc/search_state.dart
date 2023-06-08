part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class InitSearch extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends SearchState {
  final List<Movie> resultMovies;
  const SearchMovieHasData(this.resultMovies);
  @override
  List<Object> get props => [resultMovies];
}

class SearchTvHasData extends SearchState {
  final List<Tv> resultTv;
  const SearchTvHasData(this.resultTv);
  @override
  List<Object> get props => [resultTv];
}
