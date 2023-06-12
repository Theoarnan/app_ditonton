import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_watchlist.mocks.dart';

void main() {
  late WatchlistLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchlistLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('Save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(watchlistTableModel.toJson()))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(watchlistTableModel);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(watchlistTableModel.toJson()))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(watchlistTableModel);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(watchlistTableModel.id))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(watchlistTableModel);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist((watchlistTableModel.id)))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(watchlistTableModel);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get watchlist detail by id', () {
    const tId = 1;

    test('should return watchlist detail table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId)).thenAnswer(
        (_) async => testWatchlistMap,
      );
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, watchlistTableModel);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getWatchlistById(tId);
      // assert
      expect(result, null);
    });
  });

  group('Get watchlist', () {
    test('should return list of watchlist table type movie from database',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist(typeWatchlist: 'movie')).thenAnswer(
        (_) async => [testWatchlistMap],
      );
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [watchlistTableModel]);
    });

    test('should return list of watchlist table type tv from database',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist(typeWatchlist: 'tv')).thenAnswer(
        (_) async => [testWatchlistMap],
      );
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [watchlistTableModel]);
    });
  });
}
