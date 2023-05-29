import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'drawer_app_robot.dart';
import 'movies/detail_movie_robot.dart';
import 'movies/home_movie_robot.dart';
import 'movies/popular_movie_robot.dart';
import 'movies/search_movie_robot.dart';
import 'movies/top_rated_movie_robot.dart';
import 'watchlist/watchlist_movie_robot.dart';

class MoviesRobot {
  final WidgetTester tester;
  MoviesRobot(this.tester);

  late DrawerAppRobot drawerAppRobot;
  late HomeMovieRobot homeMovieRobot;
  late PopularMovieRobot popularMovieRobot;
  late TopRatedMovieRobot topRatedMovieRobot;
  late SearchMovieRobot searchMovieRobot;
  late DetailMovieRobot detailMovieRobot;
  late WatchlistMovieRobot watchlistMovieRobot;

  Future<void> homeMovieTest() async {
    // Initialize
    drawerAppRobot = DrawerAppRobot(tester);
    homeMovieRobot = HomeMovieRobot(tester);
    popularMovieRobot = PopularMovieRobot(tester);
    popularMovieRobot = PopularMovieRobot(tester);
    topRatedMovieRobot = TopRatedMovieRobot(tester);
    searchMovieRobot = SearchMovieRobot(tester);
    detailMovieRobot = DetailMovieRobot(tester);
    watchlistMovieRobot = WatchlistMovieRobot(tester);

    /// Home movie page
    await homeMovieRobot.scrollMoviePage();
    await homeMovieRobot.scrollMoviePage(scrollUp: true);

    /// Click see more popular movies and to popular movie page
    await homeMovieRobot.clickSeeMorePopularMovies();
    await popularMovieRobot.scrollPopularMoviePage();
    await popularMovieRobot.scrollPopularMoviePage(scrollUp: true);
    await popularMovieRobot.goBack();

    /// Click see more top rated movies and to top rated movie page
    await homeMovieRobot.clickSeeMoreTopRatedMovies();
    await topRatedMovieRobot.scrollTopRatedMoviePage();
    await topRatedMovieRobot.scrollTopRatedMoviePage(scrollUp: true);
    await topRatedMovieRobot.goBack();

    /// Click icon search and to search movie page
    await homeMovieRobot.clickSearchMovieButton();
    // Action search movie keyword 'mario'
    await searchMovieRobot.enterSearchQuery('mario');
    await searchMovieRobot.scrollSearchMoviePage();
    await searchMovieRobot.scrollSearchMoviePage(scrollUp: true);
    await searchMovieRobot.goBack();

    /// Click one of data popular movies to open detail movie page
    await homeMovieRobot.clickMovieItem(keyList: 'popular0');
    await detailMovieRobot.scrollDetailMoviePage();
    await detailMovieRobot.scrollRecomendationMovieDetailPage();
    await detailMovieRobot.scrollRecomendationMovieDetailPage(scrollBack: true);
    await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
    // Add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    await detailMovieRobot.clickMovieAddToWatchlistButton();
    await detailMovieRobot.goBack();

    /// Open drawer and to watchlist movies page
    await drawerAppRobot.clickNavigationDrawerButtonMovie();
    await drawerAppRobot.clickWatchlistListTile();
    await drawerAppRobot.clickWatchlistMovieListTile();
    // Watchlist movie page
    await watchlistMovieRobot.scrollWatchlistMoviePage();
    await watchlistMovieRobot.scrollWatchlistMoviePage(scrollUp: true);
    // Open detail movies in watchlist
    await watchlistMovieRobot.clickMovieItemWatchlist();
    // On detail movie page
    await detailMovieRobot.scrollDetailMoviePage();
    await detailMovieRobot.scrollRecomendationMovieDetailPage();
    await detailMovieRobot.scrollRecomendationMovieDetailPage(scrollBack: true);
    await detailMovieRobot.scrollDetailMoviePage(scrollUp: true);
    // Remove from watchlist
    expect(find.byIcon(Icons.check), findsOneWidget);
    await detailMovieRobot.clickMovieRemoveFromWatchlistButton();
    // Back to watchlist movie page
    await detailMovieRobot.goBackToWatchlist();
    await watchlistMovieRobot.goBack();
  }
}
