part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchTvDetail extends TvDetailEvent {
  final int idTvseries;
  const FetchTvDetail({required this.idTvseries});
  @override
  List<Object> get props => [idTvseries];
}

class AddToWatchlistTv extends TvDetailEvent {}

class RemoveFromWatchlistTv extends TvDetailEvent {}
