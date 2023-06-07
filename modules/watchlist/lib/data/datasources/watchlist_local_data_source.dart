import 'package:core/core.dart';
import 'package:watchlist/data/datasources/db/database_helper.dart';
import 'package:watchlist/data/models/watchlist_table_model.dart';

abstract class WatchlistLocalDataSource {
  Future<String> insertWatchlist(WatchlistTableModel watchlist);
  Future<String> removeWatchlist(WatchlistTableModel watchlist);
  Future<WatchlistTableModel?> getWatchlistById(int id);
  Future<List<WatchlistTableModel>> getWatchlistMovies();
  Future<List<WatchlistTableModel>> getWatchlistTv();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<WatchlistTableModel?> getWatchlistById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return WatchlistTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTableModel>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlist(typeWatchlist: 'movie');
    return result.map((data) => WatchlistTableModel.fromMap(data)).toList();
  }

  @override
  Future<List<WatchlistTableModel>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlist(typeWatchlist: 'tv');
    return result.map((data) => WatchlistTableModel.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(WatchlistTableModel watchlist) async {
    try {
      await databaseHelper.insertWatchlist(watchlist);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTableModel watchlist) async {
    try {
      await databaseHelper.removeWatchlist(watchlist);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
