part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();
  @override
  List<Object> get props => [];
}

class TvRecomendationEmpty extends TvRecomendationState {}

class TvRecomendationLoading extends TvRecomendationState {}

class TvRecomendationError extends TvRecomendationState {
  final String message;
  const TvRecomendationError(this.message);
  @override
  List<Object> get props => [message];
}

class TvRecomendationHasData extends TvRecomendationState {
  final List<Tv> resultTv;
  const TvRecomendationHasData(this.resultTv);
  @override
  List<Object> get props => [resultTv];
}
