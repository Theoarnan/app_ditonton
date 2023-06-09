import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../test_helper/json_reader.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  const apiKey = 'api_key=d733e78e94bdce11714e69b0946794a1';
  const baseURL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockRemoteHelper mockRemoteHelper;

  setUp(() {
    mockRemoteHelper = MockRemoteHelper();
    dataSource = MovieRemoteDataSourceImpl(remoteHelper: mockRemoteHelper);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/popular.json')))
        .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('test_helper/dummy_json/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
        json.decode(readJson('test_helper/dummy_json/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/movie_detail.json'), 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper.get(Uri.parse('$baseURL/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(json.decode(
            readJson('test_helper/dummy_json/movie_recommendations.json')))
        .movieList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/movie_recommendations.json'),
              200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(json.decode(
            readJson('test_helper/dummy_json/search_spiderman_movie.json')))
        .movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('test_helper/dummy_json/search_spiderman_movie.json'),
              200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockRemoteHelper
              .get(Uri.parse('$baseURL/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
