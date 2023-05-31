import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tGenreJson = {
    'id': 1,
    'name': 'name',
  };

  test('should be a to json from Genre Model', () async {
    final result = genreModel.toJson();
    expect(result, tGenreJson);
  });
}
