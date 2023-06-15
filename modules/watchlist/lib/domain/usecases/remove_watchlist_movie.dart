import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class RemoveWatchlistMovie {
  final WatchlistRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlistMovie(movie);
  }
}
