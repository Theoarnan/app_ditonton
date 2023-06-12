part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;
  final bool _isActiveWatchlist;
  final String _watchlistMessage;

  bool get isAddedToWatchlist => _isActiveWatchlist;
  String get watchlistMessage => _watchlistMessage;

  MovieDetailHasData({
    required this.movieDetail,
    required bool isActiveWatchlist,
    String watchlistMessage = '',
  })  : _isActiveWatchlist = isActiveWatchlist,
        _watchlistMessage = watchlistMessage;

  MovieDetailHasData changeAttr({
    bool? isActiveWatchlist,
    String watchlistMessage = '',
  }) {
    return MovieDetailHasData(
      movieDetail: movieDetail,
      isActiveWatchlist: isActiveWatchlist ?? _isActiveWatchlist,
      watchlistMessage: watchlistMessage,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        _isActiveWatchlist,
        _watchlistMessage,
      ];
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
