import 'package:app_ditonton/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/movies_robot.dart';
import 'robots/tv_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  MoviesRobot moviesRobot;
  TvRobot tvRobot;

  group('Test app', () {
    testWidgets('all feature', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      /// Inisiate value
      moviesRobot = MoviesRobot(widgetTester);
      tvRobot = TvRobot(widgetTester);

      await moviesRobot.homeMovieTest();
      await tvRobot.homeTvTest();
    });
  });
}
