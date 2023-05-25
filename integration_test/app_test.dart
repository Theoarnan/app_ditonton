import 'package:app_ditonton/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/drawer_app_robot.dart';
import 'robots/movies/detail_movie_robot.dart';
import 'robots/movies/home_movie_robot.dart';
import 'robots/movies/popular_movie_robot.dart';
import 'robots/movies/search_movie_robot.dart';
import 'robots/movies/top_rated_movie_robot.dart';
import 'robots/tv/detail_tv_robot.dart';
import 'robots/tv/home_tv_robot.dart';
import 'robots/tv/popular_tv_robot.dart';
import 'robots/tv/search_tv_robot.dart';
import 'robots/tv/season_detail_tv_robot.dart';
import 'robots/tv/top_rated_tv_robot.dart';
import 'robots/watchlist/watchlist_movie_robot.dart';
import 'robots/watchlist/watchlist_tv_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  DrawerAppRobot drawerAppRobot;
  // Movies
  HomeMovieRobot homeMovieRobot;
  DetailMovieRobot detailMovieRobot;
  PopularMovieRobot popularMovieRobot;
  TopRatedMovieRobot topRatedMovieRobot;
  SearchMovieRobot searchMovieRobot;
  // TV
  HomeTvRobot homeTvRobot;
  DetailTvRobot detailTvRobot;
  PopularTvRobot popularTvRobot;
  TopRatedTvRobot topRatedTvRobot;
  SearchTvRobot searchTvRobot;
  SeasonDetailTvRobot seasonDetailTvRobot;
  // Watchlist
  WatchlistMovieRobot watchlistMovieRobot;
  WatchlistTvRobot watchlistTvRobot;

  group('Test app', () {
    testWidgets('all features', (WidgetTester widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      // inisiate value
      drawerAppRobot = DrawerAppRobot(widgetTester);
      homeMovieRobot = HomeMovieRobot(widgetTester);
      popularMovieRobot = PopularMovieRobot(widgetTester);
      topRatedMovieRobot = TopRatedMovieRobot(widgetTester);
      detailMovieRobot = DetailMovieRobot(widgetTester);
      searchMovieRobot = SearchMovieRobot(widgetTester);

      homeTvRobot = HomeTvRobot(widgetTester);
      detailTvRobot = DetailTvRobot(widgetTester);
      detailTvRobot = DetailTvRobot(widgetTester);
      popularTvRobot = PopularTvRobot(widgetTester);
      topRatedTvRobot = TopRatedTvRobot(widgetTester);
      searchTvRobot = SearchTvRobot(widgetTester);
      seasonDetailTvRobot = SeasonDetailTvRobot(widgetTester);

      watchlistMovieRobot = WatchlistMovieRobot(widgetTester);
      watchlistTvRobot = WatchlistTvRobot(widgetTester);

      handleDetailTv() async {
        await detailTvRobot.scrollDetailTvPage();
        await detailTvRobot.scrollSeasonDetailTvPage();
        await detailTvRobot.scrollSeasonDetailTvPage(scrollBack: true);
        await detailTvRobot.clickSeasonTvItem();
        await seasonDetailTvRobot.scrollSeasonEpisodeDetailTvPage();
        await seasonDetailTvRobot.scrollSeasonEpisodeDetailTvPage(
          scrollUp: true,
        );
        await seasonDetailTvRobot.goBack();
        await detailTvRobot.scrollRecomendationDetailTvPage();
        await detailTvRobot.scrollRecomendationDetailTvPage(scrollUp: true);
        await homeTvRobot.clickTvItem(keyList: 'recomendation0tv');
        await detailTvRobot.goBack();
      }

      // show home movie
      await homeMovieRobot.scrollMoviePage();
      await homeMovieRobot.scrollMoviePage(scrollUp: true);

      // show detail movie now playing
      await homeMovieRobot.clickMovieItem(keyList: 'nowplaying0');
      await detailMovieRobot.scrollDetailMoviePage();
      await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
      await detailMovieRobot.goBack();

      // show detail movie popular
      await homeMovieRobot.scrollMoviePage();
      await homeMovieRobot.clickMovieItem(keyList: 'popular0');
      await detailMovieRobot.scrollDetailMoviePage();
      await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
      await detailMovieRobot.goBack();

      // show click see more popular movies
      await homeMovieRobot.clickSeeMorePopularMovies();
      await popularMovieRobot.scrollPopularMoviePage();
      await popularMovieRobot.scrollPopularMoviePage(scrollUp: true);
      await popularMovieRobot.goBack();

      // show detail movie top rated
      await homeMovieRobot.scrollMoviePage();
      await homeMovieRobot.clickMovieItem(keyList: 'toprated0');
      await detailMovieRobot.scrollDetailMoviePage();
      await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
      await detailMovieRobot.goBack();

      // show click see more top rated movies
      await homeMovieRobot.clickSeeMoreTopRatedMovies();
      await topRatedMovieRobot.scrollTopRatedMoviePage();
      await topRatedMovieRobot.scrollTopRatedMoviePage(scrollUp: true);
      await topRatedMovieRobot.goBack();

      // show search movie
      await homeMovieRobot.scrollMoviePage(scrollUp: true);
      await homeMovieRobot.clickSearchMovieButton();
      await searchMovieRobot.enterSearchQuery('mario');
      await searchMovieRobot.scrollSearchMoviePage();
      await searchMovieRobot.scrollSearchMoviePage(scrollUp: true);
      await homeMovieRobot.clickMovieItem(keyList: 'listMovieSearch0');
      await detailMovieRobot.scrollDetailMoviePage();
      await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
      await detailMovieRobot.goBack();
      await searchMovieRobot.goBack();

      // watchlist movie
      await homeMovieRobot.clickMovieItem(keyList: 'nowplaying0');
      await detailMovieRobot.clickMovieToWatchlistButton();
      await detailMovieRobot.goBack();
      await drawerAppRobot.clickNavigationDrawerButtonMovie();
      await drawerAppRobot.clickWatchlistListTile();
      await drawerAppRobot.clickWatchlistMovieListTile();
      await watchlistMovieRobot.scrollWatchlistMoviePage();
      await watchlistMovieRobot.scrollWatchlistMoviePage(scrollUp: true);
      await homeMovieRobot.clickMovieItem(keyList: 'watchlistMovie0');
      // remove watchlist
      await detailMovieRobot.clickMovieToWatchlistButton();
      await detailMovieRobot.goBack();
      await watchlistMovieRobot.scrollWatchlistMoviePage();
      await watchlistMovieRobot.scrollWatchlistMoviePage(scrollUp: true);
      await watchlistMovieRobot.goBack();

      // show home tv
      await drawerAppRobot.clickNavigationDrawerButtonMovie();
      await drawerAppRobot.clickTvListTile();
      await homeTvRobot.scrollTvPage();
      await homeTvRobot.scrollTvPage(scrollUp: true);

      // show detail tv on the air
      await homeTvRobot.clickTvItem(keyList: 'ontheair0tv');
      await handleDetailTv();

      // show detail tv popular
      await homeTvRobot.scrollTvPage();
      await homeTvRobot.clickTvItem(keyList: 'popular0tv');
      await handleDetailTv();

      // show click see more popular tv
      await homeTvRobot.clickSeeMorePopularTv();
      await popularTvRobot.scrollPopularTvPage();
      await popularTvRobot.scrollPopularTvPage(scrollUp: true);
      await popularTvRobot.goBack();

      // show detail tv top rated
      await homeTvRobot.scrollTvPage();
      await homeTvRobot.clickTvItem(keyList: 'toprated0tv');
      await handleDetailTv();

      // show click see more top rated tv
      await homeTvRobot.clickSeeMoreTopRatedTv();
      await topRatedTvRobot.scrollTopRatedTvPage();
      await topRatedTvRobot.scrollTopRatedTvPage(scrollUp: true);
      await topRatedTvRobot.goBack();

      // show search tv
      await homeTvRobot.scrollTvPage(scrollUp: true);
      await homeTvRobot.clickSearchTvButton();
      await searchTvRobot.enterSearchQuery('dirty');
      await searchTvRobot.scrollSearchTvPage();
      await searchTvRobot.scrollSearchTvPage(scrollUp: true);
      await homeTvRobot.clickTvItem(keyList: 'listTvSearch0');
      await handleDetailTv();
      await searchTvRobot.goBack();

      // watchlist tv
      await homeTvRobot.clickTvItem(keyList: 'ontheair0tv');
      await detailTvRobot.clickTvToWatchlistButton();
      await detailTvRobot.goBack();
      await drawerAppRobot.clickNavigationDrawerButtonTv();
      await drawerAppRobot.clickWatchlistListTile();
      await drawerAppRobot.clickWatchlistTvListTile();
      await watchlistTvRobot.scrollWatchlistTvPage();
      await watchlistTvRobot.scrollWatchlistTvPage(scrollUp: true);
      await homeTvRobot.clickTvItem(keyList: 'watchlistTv0');
      // remove watchlist
      await detailTvRobot.clickTvToWatchlistButton();
      await detailTvRobot.goBack();
      await watchlistTvRobot.scrollWatchlistTvPage();
      await watchlistTvRobot.scrollWatchlistTvPage(scrollUp: true);
      await watchlistMovieRobot.goBack();
    });
  });
}
