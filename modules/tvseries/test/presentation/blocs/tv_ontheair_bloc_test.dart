import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvOnTheAirBloc tvOnTheAirBloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetOnTheAirTv);
  });

  group('Tv on the air bloc test', () {
    test('initial state should be empty', () {
      expect(tvOnTheAirBloc.state, TvOnTheAirEmpty());
    });

    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
          (_) async => Right(tTvList),
        );
        return tvOnTheAirBloc;
      },
      act: (bloc) => bloc.fetchTvOnTheAir(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvOnTheAirLoading(),
        TvOnTheAirHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'should emit [Loading, TvOnTheAirEmpty ] when data is gotten successfully but empty',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
          (_) async => const Right([]),
        );
        return tvOnTheAirBloc;
      },
      act: (bloc) => bloc.fetchTvOnTheAir(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvOnTheAirLoading(),
        TvOnTheAirEmpty(),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<TvOnTheAirBloc, TvOnTheAirState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvOnTheAirBloc;
      },
      act: (bloc) => bloc.fetchTvOnTheAir(),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        TvOnTheAirLoading(),
        const TvOnTheAirError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });
}
