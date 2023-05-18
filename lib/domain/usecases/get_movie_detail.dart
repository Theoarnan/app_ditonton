import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/domain/entities/movie_detail.dart';
import 'package:app_ditonton/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
