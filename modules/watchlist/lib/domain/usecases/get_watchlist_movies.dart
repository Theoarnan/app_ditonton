import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistMovies {
  final WatchlistRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovie();
  }
}
