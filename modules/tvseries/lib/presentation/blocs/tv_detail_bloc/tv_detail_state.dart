part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailHasData extends TvDetailState {
  final TvDetail tvDetail;
  final bool _isActiveWatchlist;
  final String _watchlistMessage;

  bool get isAddedToWatchlist => _isActiveWatchlist;
  String get watchlistMessage => _watchlistMessage;

  TvDetailHasData({
    required this.tvDetail,
    required bool isActiveWatchlist,
    String watchlistMessage = '',
  })  : _isActiveWatchlist = isActiveWatchlist,
        _watchlistMessage = watchlistMessage;

  TvDetailHasData changeAttr({
    bool? isActiveWatchlist,
    String watchlistMessage = '',
  }) {
    return TvDetailHasData(
      tvDetail: tvDetail,
      isActiveWatchlist: isActiveWatchlist ?? _isActiveWatchlist,
      watchlistMessage: watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        tvDetail,
        _isActiveWatchlist,
        _watchlistMessage,
      ];
}

class TvDetailError extends TvDetailState {
  final String message;
  TvDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
