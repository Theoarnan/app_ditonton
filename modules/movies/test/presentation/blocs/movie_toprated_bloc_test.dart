import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MovieTopRatedBloc movieTopRatedBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  group('Movie top rated bloc test', () {
    test('initial state should be empty', () {
      expect(movieTopRatedBloc.state, MoviesTopRatedEmpty());
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.fetchMoviesTopRated(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesTopRatedLoading(),
        MovieTopRatedHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, MoviesTopRatedEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.fetchMoviesTopRated(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesTopRatedLoading(),
        MoviesTopRatedEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.fetchMoviesTopRated(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MoviesTopRatedLoading(),
        const MoviesTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
