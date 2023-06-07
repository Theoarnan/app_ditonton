import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  MovieDetailNotifier,
  PopularMoviesNotifier,
  TopRatedMoviesNotifier,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
