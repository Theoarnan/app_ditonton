import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:http/http.dart' as http;
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  SearchMovies,
  SearchTv,
  MovieSearchNotifier,
  TvSearchNotifier,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class FakeSearchEvent extends Fake implements SearchEvent {}

class FakeSearchState extends Fake implements SearchState {}
