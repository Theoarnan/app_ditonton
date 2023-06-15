import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetWatchListStatus,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  group('Movie detail bloc test', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
    });
    group('event FetchMovieDetail', () {
      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData] when detail data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(1)).thenAnswer(
            (_) async => const Right(testMovieDetail),
          );
          when(mockGetWatchListStatus.execute(1))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(idMovie: 1)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataState,
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, MovieDetailError ] when data is gotten successfully but empty',
        build: () {
          when(mockGetMovieDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(idMovie: 1)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          MovieDetailError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when watchlistStatus data is unsuccessfully',
        build: () {
          when(mockGetMovieDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          when(mockGetWatchListStatus.execute(1)).thenThrow(
            DatabaseException('Failed to get watchlist'),
          );
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(idMovie: 1)),
        expect: () => [
          MovieDetailLoading(),
          MovieDetailError('Failed to get watchlist'),
        ],
        verify: (_) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );
    });

    group('event AddToWatchlistMovie', () {
      setUp(() {
        when(mockGetMovieDetail.execute(1)).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
      });

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData] when add watchlist is gotten successfully',
        build: () {
          final valueAnswer = [false, true];
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (_) async => valueAnswer.removeAt(0),
          );
          when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Added to Watchlist'),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataState,
          tMovieDetailHasDataStateTrue.changeAttr(
            watchlistMessage: 'Added to Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData and message failure] when add watchlist is gotten unsuccessfully',
        build: () {
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (_) async => false,
          );
          when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataState,
          tMovieDetailHasDataState.changeAttr(
            watchlistMessage: 'Failed to save',
          ),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, MovieDetailError] when add watchlist is gotten unsuccessfully',
        build: () {
          final List<Future<bool> Function(Invocation)>
              mockResultDatabaseFailure = [
            (_) async => false,
            (_) => throw DatabaseException('Failed to get watchlist'),
          ];
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (invocation) => mockResultDatabaseFailure.removeAt(0)(invocation),
          );
          when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataState,
          MovieDetailError('Failed to get watchlist'),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        },
      );
    });

    group('event RemoveFromWatchlistMovie', () {
      setUp(() {
        when(mockGetMovieDetail.execute(1)).thenAnswer(
          (_) async => const Right(testMovieDetail),
        );
      });

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData] when remove watchlist is gotten successfully',
        build: () {
          final valueAnswer = [true, false];
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (_) async => valueAnswer.removeAt(0),
          );
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right('Removed from Watchlist'),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataStateTrue,
          tMovieDetailHasDataState.changeAttr(
            watchlistMessage: 'Removed from Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData and message failure] when remove watchlist is gotten unsuccessfully',
        build: () {
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (_) async => true,
          );
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to removed')),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataStateTrue,
          tMovieDetailHasDataStateTrue.changeAttr(
            watchlistMessage: 'Failed to removed',
          ),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, MovieDetailError] when remove watchlist is gotten unsuccessfully',
        build: () {
          final List<Future<bool> Function(Invocation)>
              mockResultDatabaseFailure = [
            (_) async => false,
            (_) => throw DatabaseException('Failed to get watchlist'),
          ];
          when(mockGetWatchListStatus.execute(1)).thenAnswer(
            (invocation) => mockResultDatabaseFailure.removeAt(0)(invocation),
          );
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return movieDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchMovieDetail(idMovie: 1));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistMovie()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieDetailLoading(),
          tMovieDetailHasDataState,
          MovieDetailError('Failed to get watchlist'),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1)).called(2);
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        },
      );
    });
  });
}
