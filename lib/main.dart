import 'package:app_ditonton/common/constants.dart';
import 'package:app_ditonton/common/custom_drawer.dart';
import 'package:app_ditonton/common/utils.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail_argument.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/popular_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/search_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/season_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/top_rated_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/tv_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/populer_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/season_detail_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/top_rated_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_detail_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_search_notifier.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:app_ditonton/presentation/pages/about_page.dart';
import 'package:app_ditonton/presentation/pages/home_movie_page.dart';
import 'package:app_ditonton/presentation/pages/movie_detail_page.dart';
import 'package:app_ditonton/presentation/pages/popular_movies_page.dart';
import 'package:app_ditonton/presentation/pages/search_movie_page.dart';
import 'package:app_ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:app_ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:app_ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:app_ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:app_ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:app_ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_ditonton/injection.dart' as di;
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        initialRoute: '/home-movie',
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home-movie':
              return MaterialPageRoute(
                  builder: (_) => const Material(
                      child: CustomDrawer(content: HomeMoviePage())));
            case '/home-tv':
              return MaterialPageRoute(
                  builder: (_) => const Material(
                      child: CustomDrawer(content: HomeTvPage())));
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case PopularTvPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const PopularTvPage(),
              );
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case TopRatedTvPage.routeName:
              return CupertinoPageRoute(
                builder: (_) => const TopRatedTvPage(),
              );
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const SearchMoviePage());
            case SearchTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchTvPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const WatchlistMoviesPage(),
              );
            // case WatchlistMoviesPage.routeName:
            //   return MaterialPageRoute(
            //     builder: (_) => const WatchlistMoviesPage(),
            //   );
            case SeasonDetailPage.routeName:
              final argument = settings.arguments as SeasonDetailArgument;
              return MaterialPageRoute(
                  builder: (_) => SeasonDetailPage(argument: argument));
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
