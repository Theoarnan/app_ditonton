import 'package:flutter_test/flutter_test.dart';

import '../../test_helper/dummy_data.dart';

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
