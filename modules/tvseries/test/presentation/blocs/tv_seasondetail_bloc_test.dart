import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;

  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    tvSeasonDetailBloc = TvSeasonDetailBloc(mockGetSeasonDetail);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  group('Tv season detail bloc test', () {
    test('initial state should be empty', () {
      expect(tvSeasonDetailBloc.state, TvSeasonDetailEmpty());
    });

    blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetSeasonDetail.execute(tId, tSeasonNumber)).thenAnswer(
          (_) async => const Right(testSeasonDetail),
        );
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.fetchTvSeasonDetail(
        id: tId,
        seasonNumber: tSeasonNumber,
      ),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvSeasonDetailLoading(),
        const TvSeasonDetailHasData(testSeasonDetail),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetail.execute(tId, tSeasonNumber));
      },
    );

    blocTest<TvSeasonDetailBloc, TvSeasonDetailState>(
      'should emit [Loading, Error] when get is unsuccessful',
      build: () {
        when(mockGetSeasonDetail.execute(tId, tSeasonNumber)).thenAnswer(
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.fetchTvSeasonDetail(
        id: tId,
        seasonNumber: tSeasonNumber,
      ),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        TvSeasonDetailLoading(),
        const TvSeasonDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetSeasonDetail.execute(tId, tSeasonNumber));
      },
    );
  });
}
