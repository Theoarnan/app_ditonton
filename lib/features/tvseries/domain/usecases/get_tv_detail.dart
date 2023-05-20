import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
