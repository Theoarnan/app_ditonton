import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'drawer_app_robot.dart';
import 'tv/detail_tv_robot.dart';
import 'tv/home_tv_robot.dart';
import 'tv/on_the_air_tv_robot.dart';
import 'tv/popular_tv_robot.dart';
import 'tv/search_tv_robot.dart';
import 'tv/season_detail_tv_robot.dart';
import 'tv/top_rated_tv_robot.dart';
import 'watchlist/watchlist_tv_robot.dart';

class TvRobot {
  final WidgetTester tester;
  TvRobot(this.tester);

  late DrawerAppRobot drawerAppRobot;
  late HomeTvRobot homeTvRobot;
  late OnTheAirTvRobot onTheAirTvRobot;
  late PopularTvRobot popularTvRobot;
  late TopRatedTvRobot topRatedTvRobot;
  late SearchTvRobot searchTvRobot;
  late DetailTvRobot detailTvRobot;
  late SeasonDetailTvRobot seasonDetailTvRobot;
  late WatchlistTvRobot watchlistTvRobot;

  Future<void> homeTvTest() async {
    // Initialize
    drawerAppRobot = DrawerAppRobot(tester);
    homeTvRobot = HomeTvRobot(tester);
    onTheAirTvRobot = OnTheAirTvRobot(tester);
    popularTvRobot = PopularTvRobot(tester);
    topRatedTvRobot = TopRatedTvRobot(tester);
    searchTvRobot = SearchTvRobot(tester);
    detailTvRobot = DetailTvRobot(tester);
    seasonDetailTvRobot = SeasonDetailTvRobot(tester);
    watchlistTvRobot = WatchlistTvRobot(tester);

    /// To page tv
    await drawerAppRobot.clickNavigationDrawerButtonMovie();
    await drawerAppRobot.clickTvListTile();

    /// Home tv page
    await homeTvRobot.scrollTvPage();
    await homeTvRobot.scrollTvPage(scrollUp: true);

    /// Click see more on the air tv and go to on the air tv page
    await homeTvRobot.clickSeeOnTheAirTv();
    await onTheAirTvRobot.scrollOnTheAirTvPage();
    await onTheAirTvRobot.scrollOnTheAirTvPage(scrollUp: true);
    await onTheAirTvRobot.goBack();

    /// Click see more popular tv and go to popular tv page
    await homeTvRobot.clickSeeMorePopularTv();
    await popularTvRobot.scrollPopularTvPage();
    await popularTvRobot.scrollPopularTvPage(scrollUp: true);
    await popularTvRobot.goBack();

    /// Click see more top rated tv and go to top rated tv page
    await homeTvRobot.clickSeeMoreTopRatedTv();
    await topRatedTvRobot.scrollTopRatedTvPage();
    await topRatedTvRobot.scrollTopRatedTvPage(scrollUp: true);
    await topRatedTvRobot.goBack();

    /// Click icon search and go to search tv page
    await homeTvRobot.clickSearchTvButton();
    // Action search TV keyword 'dirty'
    await searchTvRobot.enterSearchQuery('dirty');
    await searchTvRobot.scrollSearchTvPage();
    await searchTvRobot.scrollSearchTvPage(scrollUp: true);
    await searchTvRobot.goBack();

    /// Click one of data on the air tv to open detail tv page
    await homeTvRobot.clickTvItem(keyList: 'toprated0tv');
    await detailTvRobot.scrollDetailTvPage();
    // Scroll season detail tv series
    await detailTvRobot.scrollSeasonDetailTvPage();
    await detailTvRobot.scrollSeasonDetailTvPage(scrollBack: true);
    // On click season go to detail season
    await detailTvRobot.clickSeasonTvItem();
    await seasonDetailTvRobot.scrollSeasonEpisodeDetailTvPage();
    await seasonDetailTvRobot.goBack();
    // Scroll recomendation tv series
    await detailTvRobot.scrollRecomendationDetailTvPage();
    await detailTvRobot.scrollRecomendationDetailTvPage(scrollBack: true);
    await detailTvRobot.scrollDetailTvPage(scrollUp: true);
    // Add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    await detailTvRobot.clickTvAddToWatchlistButton();
    await detailTvRobot.goBack();

    /// Open drawer and to watchlist tv page
    await drawerAppRobot.clickNavigationDrawerButtonTv();
    await drawerAppRobot.clickWatchlistListTile();
    await drawerAppRobot.clickWatchlistTvListTile();
    // Watchlist tv page
    await watchlistTvRobot.scrollWatchlistTvPage();
    await watchlistTvRobot.scrollWatchlistTvPage(scrollUp: true);
    // Open detail tv in watchlist
    await watchlistTvRobot.clickTvItemWatchlist();
    // On detail tv page
    await detailTvRobot.scrollDetailTvPage();
    await detailTvRobot.scrollSeasonDetailTvPage();
    await detailTvRobot.scrollSeasonDetailTvPage(scrollBack: true);
    await detailTvRobot.clickSeasonTvItem();
    await seasonDetailTvRobot.scrollSeasonEpisodeDetailTvPage();
    await seasonDetailTvRobot.goBack();
    await detailTvRobot.scrollRecomendationDetailTvPage();
    await detailTvRobot.scrollRecomendationDetailTvPage(scrollBack: true);
    await detailTvRobot.scrollDetailTvPage(scrollUp: true);
    // Remove from watchlist
    expect(find.byIcon(Icons.check), findsOneWidget);
    await detailTvRobot.clickTvRemoveFromWatchlistButton();
    // Back to watchlist movie page
    await detailTvRobot.goBackToWatchlist();
    await watchlistTvRobot.goBack();
  }
}
