import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_recommendations.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_detail_notifier.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/remove_watchlist_tv.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 202250;
  final tTv = Tv(
    id: 202250,
    name: 'Dirty Linen',
    backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
    firstAirDate: '2023-01-23',
    genreIds: const [9648, 18],
    originalName: 'Dirty Linen',
    overview:
        'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
    popularity: 2901.537,
    posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
    voteAverage: 4.9,
    voteCount: 17,
  );
  final tTvList = <Tv>[tTv];

  void arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvList));
  }

  void arrangeUsecaseError() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => const Left(ServerFailure('Failed')));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => const Left(ServerFailure('Failed')));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvDetail, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should update error message when request in successful', () async {
      // arrange
      arrangeUsecaseError();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Failed');
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });
}
