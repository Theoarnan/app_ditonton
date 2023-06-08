import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_watchlist.mocks.dart';

void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistBloc = WatchlistBloc(mockGetWatchlistMovies, mockGetWatchlistTv);
  });

  group('Watchlist bloc test', () {
    test('initial state should be empty', () {
      expect(watchlistBloc.state, InitWatchlist());
    });

    group('movie', () {
      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => Right([testMovie]),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistLoading(),
          WatchlistMovieHasData([testMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, SearchEmpty ] when data is gotten successfully but empty',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Right([]),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistLoading(),
          WatchlistEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistMovies()),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          WatchlistLoading(),
          const WatchlistError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    });

    group('tv', () {
      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => Right([testTv]),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistLoading(),
          WatchlistTvHasData([testTv]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, SearchEmpty ] when data is gotten successfully but empty',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => const Right([]),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistLoading(),
          WatchlistEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistTv()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistLoading(),
          const WatchlistError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTv.execute());
        },
      );
    });
  });
}
