import 'package:app_ditonton/common/exception.dart';
import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/domain/entities/genre.dart';
import 'package:app_ditonton/domain/entities/movie_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv_detail.dart';
import 'package:app_ditonton/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockWatchlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  const testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  const testTvDetail = TvDetail(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'title',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originalName: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    seasons: seasons,
  );

  group('Save watchlist', () {
    group('movie', () {
      test('should return success message when saving successful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(watchlistTableModel))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlistMovie(testMovieDetail);
        // assert
        expect(result, const Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(watchlistTableModel))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlistMovie(testMovieDetail);
        // assert
        expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
      });
    });

    group('tv', () {
      test('should return success message when saving successful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(watchlistTableModel))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlistTv(testTvDetail);
        // assert
        expect(result, const Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(watchlistTableModel))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlistTv(testTvDetail);
        // assert
        expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
      });
    });
  });

  group('Remove watchlist', () {
    group('movie', () {
      test('should return success message when remove successful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(watchlistTableModel))
            .thenAnswer((_) async => 'Removed from watchlist');
        // act
        final result = await repository.removeWatchlistMovie(testMovieDetail);
        // assert
        expect(result, const Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(watchlistTableModel))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        // act
        final result = await repository.removeWatchlistMovie(testMovieDetail);
        // assert
        expect(
            result, const Left(DatabaseFailure('Failed to remove watchlist')));
      });
    });

    group('tv', () {
      test('should return success message when remove successful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(watchlistTableModel))
            .thenAnswer((_) async => 'Removed from watchlist');
        // act
        final result = await repository.removeWatchlistTv(testTvDetail);
        // assert
        expect(result, const Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(watchlistTableModel))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        // act
        final result = await repository.removeWatchlistTv(testTvDetail);
        // assert
        expect(
            result, const Left(DatabaseFailure('Failed to remove watchlist')));
      });
    });
  });

  group('Get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getWatchlistById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get watchlist', () {
    test('should return list of movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [watchlistTableModel]);
      // act
      final result = await repository.getWatchlistMovie();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
    test("should return list of tv's", () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [watchlistTableModel]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
