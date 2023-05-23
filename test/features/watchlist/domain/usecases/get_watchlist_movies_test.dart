import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistMovies usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistMovies(mockWatchlistRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlistMovie())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieList));
  });
}
