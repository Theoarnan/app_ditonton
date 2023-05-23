import 'package:app_ditonton/common/exception.dart';
import 'package:app_ditonton/domain/entities/movie_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/features/watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:app_ditonton/features/watchlist/data/models/watchlist_table_model.dart';
import 'package:app_ditonton/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:dartz/dartz.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovie() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntityMovie()).toList());
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntityTv()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getWatchlistById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv) async {
    try {
      final result = await localDataSource.removeWatchlist(
        WatchlistTableModel.fromEntityTv(tv),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistMovie(
    MovieDetail movie,
  ) async {
    try {
      final result = await localDataSource.removeWatchlist(
        WatchlistTableModel.fromEntityMovie(movie),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistMovie(MovieDetail movie) async {
    try {
      final result = await localDataSource.insertWatchlist(
        WatchlistTableModel.fromEntityMovie(movie),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv) async {
    try {
      final result = await localDataSource.insertWatchlist(
        WatchlistTableModel.fromEntityTv(tv),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
