import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(
    int id,
    int seasonNumber,
  );
}
