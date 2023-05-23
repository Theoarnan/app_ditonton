import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistTv {
  final WatchlistRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
