import 'package:core/core.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/data/models/watchlist_table_model.dart';

const watchlistTableModel = WatchlistTableModel(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  typeWatchlist: 'movie',
);

final testWatchlistMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'typeWatchlist': 'movie',
};

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  name: 'title',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalName: "originalName",
  overview: "overview",
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  seasons: seasons,
);

const seasons = <Season>[
  Season(
    airDate: "2023-01-23",
    episodeCount: 73,
    id: 294181,
    name: "Season 1",
    overview: "",
    posterPath: '/pVBxYfshGajQ600OKv8K4y8TI0K.jpg',
    seasonNumber: 1,
  )
];

final testWatchlistMovie = Movie.watchlistMovie(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = Tv.watchlistTv(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTv = Tv(
  id: 202250,
  name: 'Dirty Linen',
  backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
  firstAirDate: '2023-01-23',
  genreIds: const [9648, 18],
  originalName: 'Dirty Linen',
  overview:
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  popularity: 2901.537,
  posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
  voteAverage: 4.9,
  voteCount: 17,
);
