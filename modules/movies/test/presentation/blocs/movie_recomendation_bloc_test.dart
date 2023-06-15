import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MovieRecomendationBloc movieRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecomendationBloc = MovieRecomendationBloc(
      mockGetMovieRecommendations,
    );
  });

  group('Movie recomendation bloc test', () {
    test('initial state should be empty', () {
      expect(movieRecomendationBloc.state, MoviesRecomendationEmpty());
    });

    blocTest<MovieRecomendationBloc, MovieRecomendationState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(1)).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieRecomendationBloc;
      },
      act: (bloc) => bloc.fetchMoviesRecomendation(1),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesRecomendationLoading(),
        MovieRecomendationHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MovieRecomendationBloc, MovieRecomendationState>(
      'should emit [Loading, MoviesRecomendationEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetMovieRecommendations.execute(1)).thenAnswer(
          (_) async => const Right([]),
        );
        return movieRecomendationBloc;
      },
      act: (bloc) => bloc.fetchMoviesRecomendation(1),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesRecomendationLoading(),
        MoviesRecomendationEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MovieRecomendationBloc, MovieRecomendationState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(1)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return movieRecomendationBloc;
      },
      act: (bloc) => bloc.fetchMoviesRecomendation(1),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MoviesRecomendationLoading(),
        const MoviesRecomendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(1));
      },
    );
  });
}
