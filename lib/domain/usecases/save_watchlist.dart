import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/domain/entities/movie_detail.dart';
import 'package:app_ditonton/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
