import 'package:app_ditonton/features/tvseries/domain/entities/season.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail_argument.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const arguments = SeasonDetailArgument(
    id: 1,
    season: Season(
      airDate: "airDate",
      episodeCount: 1,
      id: 1,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 1,
    ),
  );

  group('Test argument season detail', () {
    test('should data is season detail argument', () async {
      const result = SeasonDetailArgument(
        id: 1,
        season: Season(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1,
        ),
      );
      expect(result, arguments);
      expect(result, isA<SeasonDetailArgument>());
    });
  });
}
