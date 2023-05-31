import 'package:flutter_test/flutter_test.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  final tWatchlistJson = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview',
    'typeWatchlist': 'movie',
  };

  test('should be a to json from Watchlist Table Model', () async {
    final result = watchlistTableModel.toJson();
    expect(result, tWatchlistJson);
  });
}
