import 'package:core/core.dart';
import 'package:movies/movies.dart';

const genreModel = GenreModel(
  id: 1,
  name: 'name',
);

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

const tMovieModel = MovieModel(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
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

final tMovie = Movie(
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

final tMovieModelList = <MovieModel>[tMovieModel];
final tMovieList = <Movie>[tMovie];

const tMovieResponseModel = MovieResponse(
  movieList: <MovieModel>[tMovieModel],
);

final tMovieDetailHasDataState = MovieDetailHasData(
  movieDetail: testMovieDetail,
  isActiveWatchlist: false,
);

final tMovieDetailHasDataStateTrue = MovieDetailHasData(
  movieDetail: testMovieDetail,
  isActiveWatchlist: true,
);
