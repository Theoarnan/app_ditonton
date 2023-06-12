import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_search.mocks.dart';

void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchBloc = SearchBloc(mockSearchMovies, mockSearchTv);
  });

  group('Search bloc test', () {
    test('initial state should be empty', () {
      expect(searchBloc.state, InitSearch());
    });

    group('movie', () {
      const tQuery = 'spiderman';
      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => Right(tMovieList),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedMovie(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          SearchMovieHasData(tMovieList),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, SearchEmpty ] when data is gotten successfully but empty',
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Right([]),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedMovie(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          SearchEmpty(),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedMovie(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          const SearchError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSearchMovies.execute(tQuery));
        },
      );
    });

    group('tvseries', () {
      const tQuery = 'Dirty';
      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTv.execute(tQuery)).thenAnswer(
            (_) async => Right(tTvList),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedTv(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          SearchTvHasData(tTvList),
        ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQuery));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, SearchEmpty ] when data is gotten successfully but empty',
        build: () {
          when(mockSearchTv.execute(tQuery)).thenAnswer(
            (_) async => const Right([]),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedTv(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          SearchEmpty(),
        ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQuery));
        },
      );

      blocTest<SearchBloc, SearchState>(
        'should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchTv.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')),
          );
          return searchBloc;
        },
        act: (bloc) => bloc.add(const OnQueryChangedTv(tQuery)),
        wait: const Duration(milliseconds: 600),
        expect: () => [
          SearchLoading(),
          const SearchError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQuery));
        },
      );
    });
  });
}
