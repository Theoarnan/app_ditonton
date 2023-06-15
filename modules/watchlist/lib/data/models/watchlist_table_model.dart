import 'package:equatable/equatable.dart';
import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';

class WatchlistTableModel extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? typeWatchlist;

  const WatchlistTableModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.typeWatchlist,
  });

  factory WatchlistTableModel.fromEntityMovie(MovieDetail movie) =>
      WatchlistTableModel(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        typeWatchlist: 'movie',
      );

  factory WatchlistTableModel.fromEntityTv(TvDetail tv) => WatchlistTableModel(
        id: tv.id,
        title: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        typeWatchlist: 'tv',
      );

  factory WatchlistTableModel.fromMap(Map<String, dynamic> map) =>
      WatchlistTableModel(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        typeWatchlist: map['typeWatchlist'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'typeWatchlist': typeWatchlist,
      };

  Movie toEntityMovie() => Movie.watchlistMovie(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Tv toEntityTv() => Tv.watchlistTv(
        id: id,
        overview: overview ?? '',
        posterPath: posterPath,
        name: title ?? '',
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
