import 'dart:convert';

import 'package:app_ditonton/common/exception.dart';
import 'package:app_ditonton/features/tvseries/data/models/season_detail_model.dart';
import 'package:app_ditonton/features/tvseries/data/models/tv_detail_model.dart';
import 'package:app_ditonton/features/tvseries/data/models/tv_model.dart';
import 'package:app_ditonton/features/tvseries/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

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
  static const apiKey = 'api_key=d733e78e94bdce11714e69b0946794a1';
  static const baseUrl = 'https://api.themoviedb.org/3';
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getOnTheAirTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response =
        await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeasonDetailModel> getSeasonsDetail(int id, int seasonNumber) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey'));
    if (response.statusCode == 200) {
      return SeasonDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
