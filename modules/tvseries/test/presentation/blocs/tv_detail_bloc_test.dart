import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      mockGetTvDetail,
      mockGetWatchListStatus,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  const tTvId = 202250;

  group('Tv detail bloc test', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state, TvDetailEmpty());
    });
    group('event FetchtvDetail', () {
      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData] when detail data is gotten successfully',
        build: () {
          when(mockGetTvDetail.execute(1)).thenAnswer(
            (_) async => const Right(testTvDetail),
          );
          when(mockGetWatchListStatus.execute(1))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(idTvseries: 1)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataState,
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, TvDetailError ] when data is gotten successfully but empty',
        build: () {
          when(mockGetTvDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(idTvseries: 1)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          TvDetailError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, Error] when watchlistStatus data is unsuccessfully',
        build: () {
          when(mockGetTvDetail.execute(1)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          when(mockGetWatchListStatus.execute(1)).thenThrow(
            DatabaseException('Failed to get watchlist'),
          );
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(idTvseries: 1)),
        expect: () => [
          TvDetailLoading(),
          TvDetailError('Failed to get watchlist'),
        ],
        verify: (_) {
          verify(mockGetTvDetail.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );
    });

    group('event AddToWatchlistTv', () {
      setUp(() {
        when(mockGetTvDetail.execute(tTvId)).thenAnswer(
          (_) async => const Right(testTvDetail),
        );
      });

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData] when add watchlist is gotten successfully',
        build: () {
          final valueAnswer = [false, true];
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (_) async => valueAnswer.removeAt(0),
          );
          when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Right('Added to Watchlist'),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataState,
          tTvDetailHasDataStateTrue.changeAttr(
            watchlistMessage: 'Added to Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockSaveWatchlistTv.execute(testTvDetail));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData and message failure] when add watchlist is gotten unsuccessfully',
        build: () {
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (_) async => false,
          );
          when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataState,
          tTvDetailHasDataState.changeAttr(
            watchlistMessage: 'Failed to save',
          ),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockSaveWatchlistTv.execute(testTvDetail));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, TvDetailError] when add watchlist is gotten unsuccessfully',
        build: () {
          final List<Future<bool> Function(Invocation)>
              mockResultDatabaseFailure = [
            (_) async => false,
            (_) => throw DatabaseException('Failed to get watchlist'),
          ];
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (invocation) => mockResultDatabaseFailure.removeAt(0)(invocation),
          );
          when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(AddToWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataState,
          TvDetailError('Failed to get watchlist'),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockSaveWatchlistTv.execute(testTvDetail));
        },
      );
    });

    group('event RemoveFromWatchlistMovie', () {
      setUp(() {
        when(mockGetTvDetail.execute(tTvId)).thenAnswer(
          (_) async => const Right(testTvDetail),
        );
      });

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData] when remove watchlist is gotten successfully',
        build: () {
          final valueAnswer = [true, false];
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (_) async => valueAnswer.removeAt(0),
          );
          when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Right('Removed from Watchlist'),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataStateTrue,
          tTvDetailHasDataState.changeAttr(
            watchlistMessage: 'Removed from Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockRemoveWatchlistTv.execute(testTvDetail));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData and message failure] when remove watchlist is gotten unsuccessfully',
        build: () {
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (_) async => true,
          );
          when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to removed')),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataStateTrue,
          tTvDetailHasDataStateTrue.changeAttr(
            watchlistMessage: 'Failed to removed',
          ),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockRemoveWatchlistTv.execute(testTvDetail));
        },
      );

      blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, MovieDetailError] when remove watchlist is gotten unsuccessfully',
        build: () {
          final List<Future<bool> Function(Invocation)>
              mockResultDatabaseFailure = [
            (_) async => false,
            (_) => throw DatabaseException('Failed to get watchlist'),
          ];
          when(mockGetWatchListStatus.execute(tTvId)).thenAnswer(
            (invocation) => mockResultDatabaseFailure.removeAt(0)(invocation),
          );
          when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Failed to save')),
          );
          return tvDetailBloc;
        },
        act: (bloc) {
          bloc.add(const FetchTvDetail(idTvseries: tTvId));
          Future.delayed(Duration.zero)
              .then((value) => bloc.add(RemoveFromWatchlistTv()));
        },
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvDetailLoading(),
          tTvDetailHasDataState,
          TvDetailError('Failed to get watchlist'),
        ],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tTvId));
          verify(mockGetWatchListStatus.execute(tTvId)).called(2);
          verify(mockRemoveWatchlistTv.execute(testTvDetail));
        },
      );
    });
  });
}
