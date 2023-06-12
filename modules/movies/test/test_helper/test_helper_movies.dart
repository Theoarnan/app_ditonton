import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
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
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// Mock MovieNowPlayingBloc
class MockMovieNowPlayingBloc extends MockCubit<MovieNowPlayingState>
    implements MovieNowPlayingBloc {}

class MockMovieNowPlayingState extends Fake implements MovieNowPlayingState {}

// Mock MoviePopularBloc
class MockMoviePopularBloc extends MockCubit<MoviePopularState>
    implements MoviePopularBloc {}

class MockMoviePopularState extends Fake implements MoviePopularState {}

// Mock MovieTopRatedBloc
class MockMovieTopRatedBloc extends MockCubit<MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MockMovieTopRatedState extends Fake implements MovieTopRatedState {}

// Mock MovieDetailBloc
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

// Mock MovieRecomendationBloc
class MockMovieRecomendationBloc extends MockCubit<MovieRecomendationState>
    implements MovieRecomendationBloc {}

class MockMovieRecomendationState extends Fake
    implements MovieRecomendationState {}
