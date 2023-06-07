import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:watchlist/data/models/watchlist_table_model.dart';

import '../../../test_helper/dummy_data.dart';
import '../../../test_helper/test_helper_watchlist.mocks.dart';

void main() {
  late Database database;
  late MockDatabaseHelper databaseHelper;
  List<WatchlistTableModel> listWatchlist = List.generate(
    10,
    (index) => watchlistTableModel,
  );

  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute('''
      CREATE TABLE  watchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        typeWatchlist TEXT
      );
    ''');
    databaseHelper = MockDatabaseHelper();
    databaseHelper.database = Future.microtask(() => database);
    when(databaseHelper.getWatchlist(typeWatchlist: 'movie')).thenAnswer(
      (_) async => listWatchlist.map((e) => e.toJson()).toList(),
    );
    when(databaseHelper.insertWatchlist(any)).thenAnswer((_) async => 1);
    when(databaseHelper.removeWatchlist(any)).thenAnswer((_) async => 1);
    when(databaseHelper.getWatchlistById(any)).thenAnswer(
      (_) async => watchlistTableModel.toJson(),
    );
  });

  group('Database Test', () {
    test('sqflite version', () async {
      expect(await database.getVersion(), 0);
    });

    test('add item watchlist to database', () async {
      var i = await database.insert('watchlist', watchlistTableModel.toJson());
      var p = await database.query('watchlist');
      expect(p.length, i);
    });

    test('get item watchlist by id from database', () async {
      await database.query('watchlist', where: 'id = ?', whereArgs: [1]);
      var p = await database.query('watchlist');
      expect(p.length, 1);
    });

    test('delete item watchlist by id from database', () async {
      await database.delete('watchlist', where: 'id = ?', whereArgs: [1]);
      var p = await database.query('watchlist');
      expect(p.length, 0);
    });
  });

  group("Service db", () {
    test("insert watchlist", () async {
      verifyNever(databaseHelper.insertWatchlist(watchlistTableModel));
      expect(await databaseHelper.insertWatchlist(watchlistTableModel), 1);
      verify(databaseHelper.insertWatchlist(watchlistTableModel)).called(1);
    });

    test("get watchlist by type watchlist", () async {
      verifyNever(databaseHelper.getWatchlist(typeWatchlist: 'movie'));
      expect(
        await databaseHelper.getWatchlist(typeWatchlist: 'movie'),
        listWatchlist.map((e) => e.toJson()).toList(),
      );
      verify(databaseHelper.getWatchlist(typeWatchlist: 'movie')).called(1);
    });

    test("get watchlist by id", () async {
      verifyNever(databaseHelper.getWatchlistById(1));
      expect(
        await databaseHelper.getWatchlistById(1),
        watchlistTableModel.toJson(),
      );
      verify(databaseHelper.getWatchlistById(1)).called(1);
    });

    test("remove watchlist by id", () async {
      verifyNever(databaseHelper.removeWatchlist(watchlistTableModel));
      expect(await databaseHelper.removeWatchlist(watchlistTableModel), 1);
      verify(databaseHelper.removeWatchlist(watchlistTableModel)).called(1);
    });
  });
}
