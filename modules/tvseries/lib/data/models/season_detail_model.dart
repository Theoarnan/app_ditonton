import 'package:equatable/equatable.dart';
import 'package:tvseries/data/models/episode_model.dart';
import 'package:tvseries/domain/entities/season_detail.dart';

class SeasonDetailModel extends Equatable {
  final int id;
  final String? airDate;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final List<EpisodeModel> episodes;

  const SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodes,
  });

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json["id"],
        airDate: json["air_date"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        seasonNumber: json["season_number"],
        episodes: List<EpisodeModel>.from(
          json["episodes"].map((x) => EpisodeModel.fromJson(x)),
        ),
      );

  SeasonDetail toEntity() {
    return SeasonDetail(
      id: id,
      airDate: airDate ?? '',
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        airDate,
        overview,
        posterPath,
        seasonNumber,
        episodes,
      ];
}
