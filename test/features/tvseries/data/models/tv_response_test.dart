import 'dart:convert';

import 'package:app_ditonton/features/tvseries/data/models/tv_model.dart';
import 'package:app_ditonton/features/tvseries/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
    firstAirDate: '2023-01-23',
    genreIds: [9648, 18],
    id: 202250,
    name: 'Dirty Linen',
    originCountry: ['PH'],
    originalLanguage: 'tl',
    originalName: 'Dirty Linen',
    overview:
        'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
    popularity: 2901.537,
    posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
    voteAverage: 4.9,
    voteCount: 17,
  );

  const tTvResponseModel = TvResponse(
    tvList: <TvModel>[tTvModel],
  );

  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/tv_list.json'));
    // act
    final result = TvResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvResponseModel);
  });
}
