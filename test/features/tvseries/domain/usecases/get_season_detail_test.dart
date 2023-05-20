import 'package:app_ditonton/features/tvseries/domain/usecases/get_season_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetSeasonDetail(mockTvRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => const Right(testSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, const Right(testSeasonDetail));
  });
}
