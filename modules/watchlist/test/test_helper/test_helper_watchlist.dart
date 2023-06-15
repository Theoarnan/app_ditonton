import 'package:bloc_test/bloc_test.dart';
import 'package:core/data/datasources/local/database_helper.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

@GenerateMocks([
  DatabaseHelper,
  WatchlistRepository,
  WatchlistLocalDataSource,
  GetWatchlistMovies,
  GetWatchlistTv,
])
void main() {}

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class FakeWatchlistEvent extends Fake implements WatchlistEvent {}

class FakeWatchlistState extends Fake implements WatchlistState {}
