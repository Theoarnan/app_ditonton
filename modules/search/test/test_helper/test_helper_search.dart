import 'package:mockito/annotations.dart';
import 'package:movies/movies.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';
import 'package:http/http.dart' as http;
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
