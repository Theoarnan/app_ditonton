import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchlistTv getWatchlistTv;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchlistTv,
  });

  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;
    notifyListeners();
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();
    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
