import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  final int id;
  final String name;
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  const Tv({
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
