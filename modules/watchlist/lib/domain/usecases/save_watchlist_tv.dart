import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class SaveWatchlistTv {
  final WatchlistRepository repository;

  SaveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
