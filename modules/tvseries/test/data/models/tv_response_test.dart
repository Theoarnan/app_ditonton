import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/json_reader.dart';

void main() {
  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('test_helper/dummy_json/tv_list.json'));
    // act
    final result = TvResponse.fromJson(jsonMap);
    // assert
    expect(result, tTvResponseModel);
  });
}
