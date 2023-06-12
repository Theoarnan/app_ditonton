part of 'tv_seasondetail_bloc.dart';

abstract class TvSeasonDetailState extends Equatable {
  const TvSeasonDetailState();
  @override
  List<Object> get props => [];
}

class TvSeasonDetailEmpty extends TvSeasonDetailState {}

class TvSeasonDetailLoading extends TvSeasonDetailState {}

class TvSeasonDetailError extends TvSeasonDetailState {
  final String message;
  const TvSeasonDetailError(this.message);
  @override
  List<Object> get props => [message];
}

class TvSeasonDetailHasData extends TvSeasonDetailState {
  final SeasonDetail resultSeasonDetail;
  const TvSeasonDetailHasData(this.resultSeasonDetail);
  @override
  List<Object> get props => [resultSeasonDetail];
}
