part of 'tv_ontheair_bloc.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();
  @override
  List<Object> get props => [];
}

class TvOnTheAirEmpty extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;
  const TvOnTheAirError(this.message);
  @override
  List<Object> get props => [message];
}

class TvOnTheAirHasData extends TvOnTheAirState {
  final List<Tv> resultTv;
  const TvOnTheAirHasData(this.resultTv);
  @override
  List<Object> get props => [resultTv];
}
