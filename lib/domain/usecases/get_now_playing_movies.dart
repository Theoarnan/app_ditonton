import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
