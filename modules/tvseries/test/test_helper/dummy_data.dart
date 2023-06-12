import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

const tTvModel = TvModel(
  backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
  firstAirDate: '2023-01-23',
  genreIds: [9648, 18],
  id: 202250,
  name: 'Dirty Linen',
  originCountry: ['PH'],
  originalLanguage: 'tl',
  originalName: 'Dirty Linen',
  overview:
      'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
  popularity: 2901.537,
  posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
  voteAverage: 4.9,
  voteCount: 17,
);

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

const tTvResponseModel = TvResponse(
  tvList: <TvModel>[tTvModel],
);

final tTvModelList = <TvModel>[tTvModel];
final tTvList = <Tv>[tTv];

const seasonsModel = <SeasonModel>[
  SeasonModel(
    airDate: "2023-01-23",
    episodeCount: 73,
    id: 294181,
    name: "Season 1",
    overview: "",
    posterPath: '/pVBxYfshGajQ600OKv8K4y8TI0K.jpg',
    seasonNumber: 1,
  ),
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

const tTvDetailModel = TvDetailModel(
  adult: false,
  backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
  firstAirDate: '2023-01-23',
  genres: [GenreModel(id: 9648, name: 'Mystery')],
  id: 202250,
  name: 'Dirty Linen',
  numberOfEpisodes: 93,
  numberOfSeasons: 2,
  originCountry: ["PH"],
  originalLanguage: 'tl',
  originalName: "Dirty Linen",
  overview:
      "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
  popularity: 2901.537,
  posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
  voteAverage: 4.941,
  voteCount: 17,
  seasons: seasonsModel,
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
  ),
  Season(
    airDate: "2023-01-23",
    episodeCount: 73,
    id: 294181,
    name: "Season 1",
    overview: "",
    posterPath: '/pVBxYfshGajQ600OKv8K4y8TI0K.jpg',
    seasonNumber: 1,
  ),
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

const episode = Episode(
  airDate: "2023-01-23",
  episodeNumber: 1,
  id: 3727904,
  name: "Four Underground",
  overview:
      "The powerful and influential Fiero clan celebrates the 15th anniversary of their cockpit arena built on the remains of a tragic and bloody past. A girl stops at nothing until she unravels the mystery behind her mother's disappearance.",
  seasonNumber: 1,
  stillPath: "/8u3iGSXXTNA46GPcvgzmMBSjnkj.jpg",
  voteAverage: 10.0,
  voteCount: 1,
);

const episodes = <Episode>[episode, episode];

const testSeasonDetail = SeasonDetail(
  id: 294181,
  airDate: "2023-01-23",
  name: "Season 1",
  overview: "",
  posterPath: "/pVBxYfshGajQ600OKv8K4y8TI0K.jpg",
  seasonNumber: 1,
  episodes: episodes,
);

const testSeasonDetailEmptyEpisode = SeasonDetail(
  id: 294181,
  airDate: "2023-01-23",
  name: "Season 1",
  overview: "",
  posterPath: "/pVBxYfshGajQ600OKv8K4y8TI0K.jpg",
  seasonNumber: 1,
  episodes: [],
);

const tId = 1;
const arguments = SeasonDetailArgument(
  id: tId,
  season: Season(
    airDate: "2023-05-11",
    episodeCount: 1,
    id: tId,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
  ),
);

final tTvDetailHasDataState = TvDetailHasData(
  tvDetail: testTvDetail,
  isActiveWatchlist: false,
);

final tTvDetailHasDataStateTrue = TvDetailHasData(
  tvDetail: testTvDetail,
  isActiveWatchlist: true,
);
