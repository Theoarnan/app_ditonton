import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  GetOnTheAirTv,
  GetPopularTv,
  GetSeasonDetail,
  GetTopRatedTv,
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
  TvListNotifier,
  OnTheAirTvNotifier,
  PopularTvNotifier,
  SeasonDetailNotifier,
  TopRatedTvNotifier,
  TvDetailNotifier,
  // MovieRepository,
  // MovieRemoteDataSource,
  // GetMovieDetail,
  // GetMovieRecommendations,
  // GetWatchListStatus,
  // SaveWatchlistMovie,
  // RemoveWatchlistMovie,
  // GetNowPlayingMovies,
  // GetPopularMovies,
  // GetTopRatedMovies,
  // MovieDetailNotifier,
  // PopularMoviesNotifier,
  // TopRatedMoviesNotifier,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
