import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvRecomendationBloc tvRecomendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecomendationBloc = TvRecomendationBloc(mockGetTvRecommendations);
  });

  group('Tv recomendation bloc test', () {
    test('initial state should be empty', () {
      expect(tvRecomendationBloc.state, TvRecomendationEmpty());
    });

    blocTest<TvRecomendationBloc, TvRecomendationState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(1)).thenAnswer(
          (_) async => Right(tTvList),
        );
        return tvRecomendationBloc;
      },
      act: (bloc) => bloc.fetchTvRecomendation(1),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvRecomendationLoading(),
        TvRecomendationHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(1));
      },
    );

    blocTest<TvRecomendationBloc, TvRecomendationState>(
      'should emit [Loading, TvRecomendationEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetTvRecommendations.execute(1)).thenAnswer(
          (_) async => const Right([]),
        );
        return tvRecomendationBloc;
      },
      act: (bloc) => bloc.fetchTvRecomendation(1),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvRecomendationLoading(),
        TvRecomendationEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(1));
      },
    );

    blocTest<TvRecomendationBloc, TvRecomendationState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(1)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvRecomendationBloc;
      },
      act: (bloc) => bloc.fetchTvRecomendation(1),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        TvRecomendationLoading(),
        const TvRecomendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(1));
      },
    );
  });
}
