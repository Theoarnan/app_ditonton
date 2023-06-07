import 'package:mockito/annotations.dart';
import 'package:watchlist/data/datasources/db/database_helper.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv.dart';
import 'package:watchlist/presentation/provider/watchlist_notifier.dart';

@GenerateMocks([
  DatabaseHelper,
  WatchlistRepository,
  WatchlistLocalDataSource,
  WatchlistNotifier,
  GetWatchlistMovies,
  GetWatchlistTv,
])
void main() {}
