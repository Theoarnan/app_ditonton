import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/blocs/movie_nowplaying_bloc/movie_nowplaying_bloc.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  group('Movie now playing bloc test', () {
    test('initial state should be empty', () {
      expect(movieNowPlayingBloc.state, MoviesNowPlayingEmpty());
    });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.fetchMoviesNowPlaying(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesNowPlayingLoading(),
        MovieNowPlayingHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, MoviesNowPlayingEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.fetchMoviesNowPlaying(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MoviesNowPlayingLoading(),
        MoviesNowPlayingEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.fetchMoviesNowPlaying(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MoviesNowPlayingLoading(),
        const MoviesNowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
