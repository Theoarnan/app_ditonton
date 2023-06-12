import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvTopRatedBloc tvTopRatedBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTv);
  });

  group('Tv top rated bloc test', () {
    test('initial state should be empty', () {
      expect(tvTopRatedBloc.state, TvTopRatedEmpty());
    });

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
          (_) async => Right(tTvList),
        );
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.fetchTvTopRated(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, TvTopRatedEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.fetchTvTopRated(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.fetchTvTopRated(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        TvTopRatedLoading(),
        const TvTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
