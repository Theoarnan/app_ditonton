part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int idMovie;
  const FetchMovieDetail({required this.idMovie});
  @override
  List<Object> get props => [idMovie];
}

class AddToWatchlistMovie extends MovieDetailEvent {}

class RemoveFromWatchlistMovie extends MovieDetailEvent {}
