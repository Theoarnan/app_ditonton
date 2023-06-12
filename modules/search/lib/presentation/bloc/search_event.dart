part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class OnQueryChangedMovie extends SearchEvent {
  final String query;
  const OnQueryChangedMovie(this.query);
  @override
  List<Object> get props => [query];
}

class OnQueryChangedTv extends SearchEvent {
  final String query;
  const OnQueryChangedTv(this.query);
  @override
  List<Object> get props => [query];
}
