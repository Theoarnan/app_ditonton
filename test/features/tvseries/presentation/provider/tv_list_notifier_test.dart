import 'package:app_ditonton/common/failure.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_on_the_air_tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_popular_tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListNotifier(
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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

  group('On the air tv', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTv();
      // assert
      verify(mockGetOnTheAirTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.loaded);
      expect(provider.onTheAirTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
