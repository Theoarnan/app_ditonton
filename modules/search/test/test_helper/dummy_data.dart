import 'package:movies/movies.dart';
import 'package:tvseries/tvseries.dart';

final tMovieModel = Movie(
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

final tMovieList = <Movie>[tMovieModel];

final tTv = Tv(
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

final tTvList = <Tv>[tTv];
