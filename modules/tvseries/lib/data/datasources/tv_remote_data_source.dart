import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<List<TvModel>> getPopularTv();
  Future<TvDetailModel> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTv(String query);
  Future<SeasonDetailModel> getSeasonsDetail(int id, int seasonNumber);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;
  TvRemoteDataSourceImpl({required this.client});

  static const apiKey = 'api_key=$baseAPIKey';

  @override
  Future<List<TvModel>> getOnTheAirTv() async {
    final response = await client.get(
      Uri.parse('$baseURL/tv/on_the_air?$apiKey'),
    );
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response = await client.get(
      Uri.parse('$baseURL/tv/top_rated?$apiKey'),
    );
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await client.get(Uri.parse('$baseURL/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$baseURL/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$baseURL/tv/$id/recommendations?$apiKey'),
    );
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await client.get(
      Uri.parse('$baseURL/search/tv?$apiKey&query=$query'),
    );
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonsDetail(int id, int seasonNumber) async {
    final response = await client.get(
      Uri.parse('$baseURL/tv/$id/season/$seasonNumber?$apiKey'),
    );
    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
