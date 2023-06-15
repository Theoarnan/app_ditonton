import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvPopularBloc tvPopularBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(mockGetPopularTv);
  });

  group('Tv popular bloc test', () {
    test('initial state should be empty', () {
      expect(tvPopularBloc.state, TvPopularEmpty());
    });

    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => Right(tTvList),
        );
        return tvPopularBloc;
      },
      act: (bloc) => bloc.fetchTvPopular(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvPopularLoading(),
        TvPopularHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, TvPopularEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return tvPopularBloc;
      },
      act: (bloc) => bloc.fetchTvPopular(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvPopularLoading(),
        TvPopularEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvPopularBloc;
      },
      act: (bloc) => bloc.fetchTvPopular(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        TvPopularLoading(),
        const TvPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
