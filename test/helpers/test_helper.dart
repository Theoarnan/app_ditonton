import 'package:app_ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:app_ditonton/domain/repositories/movie_repository.dart';
import 'package:app_ditonton/features/tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:app_ditonton/features/tvseries/domain/repositories/tv_repository.dart';
import 'package:app_ditonton/features/watchlist/data/datasources/db/database_helper.dart';
import 'package:app_ditonton/features/watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:app_ditonton/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  DatabaseHelper,
  TvRepository,
  TvRemoteDataSource,
  WatchlistLocalDataSource,
  WatchlistRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
