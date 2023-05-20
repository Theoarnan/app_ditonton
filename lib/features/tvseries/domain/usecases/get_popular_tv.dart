import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetPopularTv {
  final TvRepository repository;

  GetPopularTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
