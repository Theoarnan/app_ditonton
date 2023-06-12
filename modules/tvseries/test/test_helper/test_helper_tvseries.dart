import 'package:bloc_test/bloc_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
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
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// Mock TvOnTheAirBloc
class MockTvOnTheAirBloc extends MockCubit<TvOnTheAirState>
    implements TvOnTheAirBloc {}

class MockTvOnTheAirState extends Fake implements TvOnTheAirState {}

// Mock TvPopularBloc
class MockTvPopularBloc extends MockCubit<TvPopularState>
    implements TvPopularBloc {}

class MockTvPopularState extends Fake implements TvPopularState {}

// Mock TvTopRatedBloc
class MockTvTopRatedBloc extends MockCubit<TvTopRatedState>
    implements TvTopRatedBloc {}

class MockTvTopRatedState extends Fake implements TvTopRatedState {}

// Mock TvDetailBloc
class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

// Mock TvRecomendationBloc
class MockTvRecomendationBloc extends MockCubit<TvRecomendationState>
    implements TvRecomendationBloc {}

// Mock TvSeasonDetailBloc
class MockTvSeasonDetailBloc extends MockCubit<TvSeasonDetailState>
    implements TvSeasonDetailBloc {}

class MockTvSeasonDetailState extends Fake implements TvSeasonDetailState {}
