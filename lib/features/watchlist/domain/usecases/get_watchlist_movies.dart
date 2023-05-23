import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistMovies {
  final WatchlistRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovie();
  }
}
