import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';

import '../../test_helper/json_reader.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  const apiKey = 'api_key=d733e78e94bdce11714e69b0946794a1';
  const baseURL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockRemoteHelper mockRemoteHelper;

  setUp(() {
    mockRemoteHelper = MockRemoteHelper();
    dataSource = TvRemoteDataSourceImpl(remoteHelper: mockRemoteHelper);
  });

  group('get on the air tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/tv_list.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('test_helper/dummy_json/tv_list.json'), 200),
      );
      // act
      final result = await dataSource.getOnTheAirTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/tv_list.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('test_helper/dummy_json/tv_list.json'), 200),
      );
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/tv_list.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/popular?$apiKey')))
          .thenAnswer(
        (_) async =>
            http.Response(readJson('test_helper/dummy_json/tv_list.json'), 200),
      );
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 202250;
    final tTvDetail = TvDetailModel.fromJson(
        json.decode(readJson('test_helper/dummy_json/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvDetail(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(json
            .decode(readJson('test_helper/dummy_json/tv_recommendations.json')))
        .tvList;
    const tId = 202250;

    test('should return list of Tv Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(tId);
      // assert
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/tv_list.json')))
        .tvList;
    const tQuery = 'Dirty';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/tv_list.json'), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTv(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Season detail', () {
    const tId = 294181;
    const tSeasonNumber = 1;
    final tSeasonDetail = SeasonDetailModel.fromJson(
        json.decode(readJson('test_helper/dummy_json/season_detail.json')));

    test('should return season detail when the response code is 200', () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/season_detail.json'), 200));
      // act
      final result = await dataSource.getSeasonsDetail(tId, tSeasonNumber);
      // assert
      expect(result, equals(tSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/tv/$tId/season/$tSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeasonsDetail(tId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
