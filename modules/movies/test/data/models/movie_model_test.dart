import 'package:flutter_test/flutter_test.dart';

import '../../test_helper/dummy_data.dart';

void main() {
  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
}
