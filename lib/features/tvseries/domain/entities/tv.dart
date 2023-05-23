import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  int id;
  String name;
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  Tv({
    required this.id,
    required this.name,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlistTv({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        backdropPath,
        firstAirDate,
        genreIds,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];
}
