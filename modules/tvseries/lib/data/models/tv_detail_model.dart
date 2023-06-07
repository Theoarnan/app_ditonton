import 'package:core/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class TvDetailModel extends Equatable {
  final bool adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final List<SeasonModel> seasons;

  const TvDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
  });

  factory TvDetailModel.fromJson(Map<String, dynamic> json) => TvDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
          json["genres"].map((x) => GenreModel.fromJson(x)),
        ),
        id: json["id"],
        name: json["name"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        seasons: List<SeasonModel>.from(
          json["seasons"].map((x) => SeasonModel.fromJson(x)),
        ),
      );

  TvDetail toEntity() {
    return TvDetail(
      firstAirDate: firstAirDate,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      popularity: popularity,
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        seasons
      ];
}
