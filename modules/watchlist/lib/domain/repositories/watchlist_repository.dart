import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie);
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlistMovie(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovie();
  Future<Either<Failure, List<Tv>>> getWatchlistTv();
}
