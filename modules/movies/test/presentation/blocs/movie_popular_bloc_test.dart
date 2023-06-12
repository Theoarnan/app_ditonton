import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MoviePopularBloc moviePopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  group('Movie popular bloc test', () {
    test('initial state should be empty', () {
      expect(moviePopularBloc.state, MoviesPopularEmpty());
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return moviePopularBloc;
      },
      act: (bloc) => bloc.fetchMoviesPopular(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesPopularLoading(),
        MoviePopularHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, MoviesPopularEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return moviePopularBloc;
      },
      act: (bloc) => bloc.fetchMoviesPopular(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesPopularLoading(),
        MoviesPopularEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return moviePopularBloc;
      },
      act: (bloc) => bloc.fetchMoviesPopular(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MoviesPopularLoading(),
        const MoviesPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
