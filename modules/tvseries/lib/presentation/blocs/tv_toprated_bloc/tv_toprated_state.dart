part of 'tv_toprated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();
  @override
  List<Object> get props => [];
}

class TvTopRatedEmpty extends TvTopRatedState {}

class TvTopRatedLoading extends TvTopRatedState {}

class TvTopRatedError extends TvTopRatedState {
  final String message;
  const TvTopRatedError(this.message);
  @override
  List<Object> get props => [message];
}

class TvTopRatedHasData extends TvTopRatedState {
  final List<Tv> resultTv;
  const TvTopRatedHasData(this.resultTv);
  @override
  List<Object> get props => [resultTv];
}
