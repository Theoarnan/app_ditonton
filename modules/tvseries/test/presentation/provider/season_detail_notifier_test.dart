import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late SeasonDetailNotifier provider;
  late MockGetSeasonDetail mockGetSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeasonDetail = MockGetSeasonDetail();
    provider = SeasonDetailNotifier(
      getSeasonDetail: mockGetSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 294181;
  const tNumberSeason = 1;

  void arrangeUsecase() {
    when(mockGetSeasonDetail.execute(tId, tNumberSeason))
        .thenAnswer((_) async => const Right(testSeasonDetail));
  }

  group('Get Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(id: tId, seasonNumber: tNumberSeason);
      // assert
      verify(mockGetSeasonDetail.execute(tId, tNumberSeason));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchSeasonDetail(id: tId, seasonNumber: tNumberSeason);
      // assert
      expect(provider.seasonState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change season when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeasonDetail(id: tId, seasonNumber: tNumberSeason);
      // assert
      expect(provider.seasonState, RequestState.loaded);
      expect(provider.seasonDetail, testSeasonDetail);
      expect(listenerCallCount, 2);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeasonDetail.execute(tId, tNumberSeason))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeasonDetail(id: tId, seasonNumber: tNumberSeason);
      // assert
      expect(provider.seasonState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });
}
