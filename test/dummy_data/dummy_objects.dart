import 'package:app_ditonton/data/models/genre_model.dart';
import 'package:app_ditonton/data/models/movie_detail_model.dart';
import 'package:app_ditonton/domain/entities/genre.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/domain/entities/movie_detail.dart';
import 'package:app_ditonton/features/tvseries/data/models/season_model.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/episode.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:app_ditonton/features/watchlist/data/models/watchlist_table_model.dart';

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

final testMovieList = [testMovie];

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

final testTvList = <Tv>[testTv];

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

const seasonsModel = <SeasonModel>[
  SeasonModel(
    airDate: "2023-01-23",
    episodeCount: 73,
    id: 294181,
    name: "Season 1",
    overview: "",
    posterPath: '/pVBxYfshGajQ600OKv8K4y8TI0K.jpg',
    seasonNumber: 1,
  )
];

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

const testTvDetail = TvDetail(
  adult: false,
  backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
  firstAirDate: '2023-01-23',
  genres: [Genre(id: 9648, name: 'Mystery')],
  id: 202250,
  name: 'Dirty Linen',
  numberOfEpisodes: 93,
  numberOfSeasons: 2,
  originalName: "Dirty Linen",
  overview:
      "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  popularity: 2901.537,
  posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
  voteAverage: 4.941,
  voteCount: 17,
  seasons: seasons,
);

const episodes = <Episode>[
  Episode(
    airDate: "2023-01-23",
    episodeNumber: 1,
    id: 3727904,
    name: "Four Underground",
    overview:
        "The powerful and influential Fiero clan celebrates the 15th anniversary of their cockpit arena built on the remains of a tragic and bloody past. A girl stops at nothing until she unravels the mystery behind her mother's disappearance.",
    runtime: 46,
    seasonNumber: 1,
    stillPath: "/8u3iGSXXTNA46GPcvgzmMBSjnkj.jpg",
    voteAverage: 10.0,
    voteCount: 1,
  )
];

const testSeasonDetail = SeasonDetail(
  id: 294181,
  airDate: "2023-01-23",
  name: "Season 1",
  overview: "",
  posterPath: "/pVBxYfshGajQ600OKv8K4y8TI0K.jpg",
  seasonNumber: 1,
  episodes: episodes,
);

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

const genreModel = GenreModel(
  id: 1,
  name: 'name',
);

const testMovieDetailModel = MovieDetailResponse(
  adult: false,
  backdropPath: "backdropPath",
  budget: 1,
  genres: [],
  homepage: "homepage",
  id: 1,
  imdbId: "imdbId",
  originalLanguage: "originalLanguage",
  originalTitle: "originalTitle",
  overview: "overview",
  popularity: 2,
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  revenue: 1,
  runtime: 2,
  status: "status",
  tagline: "tagline",
  title: "title",
  video: false,
  voteAverage: 2,
  voteCount: 3,
);
