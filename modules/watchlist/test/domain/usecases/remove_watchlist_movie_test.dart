import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/remove_watchlist_movie.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_watchlist.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveWatchlistMovie(mockWatchlistRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockWatchlistRepository.removeWatchlistMovie(testMovieDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockWatchlistRepository.removeWatchlistMovie(testMovieDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
