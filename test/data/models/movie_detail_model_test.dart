import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tMovieDetailJson = {
    "adult": false,
    "backdrop_path": 'backdropPath',
    "budget": 1,
    "genres": [],
    "homepage": 'homepage',
    "id": 1,
    "imdb_id": "imdbId",
    "original_language": "originalLanguage",
    "original_title": "originalTitle",
    "overview": "overview",
    "popularity": 2,
    "poster_path": "posterPath",
    "release_date": "releaseDate",
    "revenue": 1,
    "runtime": 2,
    "status": "status",
    "tagline": "tagline",
    "title": "title",
    "video": false,
    "vote_average": 2,
    "vote_count": 3,
  };

  test('should be a to json from Movie Detail Model', () async {
    final result = testMovieDetailModel.toJson();
    expect(result, tMovieDetailJson);
  });
}
