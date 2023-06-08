import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:app_ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/watchlist.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
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
        ChangeNotifierProvider(
          create: (_) => di.locator<OnTheAirTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: TextTheme(
            titleMedium: kHeading5,
            titleSmall: kHeading6,
            bodyMedium: kBodyText,
          ),
        ),
        initialRoute: '/home-movie',
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMovieRoute:
              return MaterialPageRoute(
                  builder: (_) => const Material(
                      child: CustomDrawer(content: HomeMoviePage())));
            case homeTvRoute:
              return MaterialPageRoute(
                  builder: (_) => const Material(
                      child: CustomDrawer(content: HomeTvPage())));
            case popularMovieRoute:
              return MaterialPageRoute(
                builder: (_) => const PopularMoviesPage(),
              );
            case popularTvRoute:
              return MaterialPageRoute(
                builder: (_) => const PopularTvPage(),
              );
            case topRatedMovieRoute:
              return MaterialPageRoute(
                builder: (_) => const TopRatedMoviesPage(),
              );
            case topRatedTvRoute:
              return MaterialPageRoute(
                builder: (_) => const TopRatedTvPage(),
              );
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case detailTvRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return MaterialPageRoute(builder: (_) => const SearchMoviePage());
            case searchTvRoute:
              return MaterialPageRoute(builder: (_) => const SearchTvPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case watchlistMovieRoute:
              return MaterialPageRoute(
                builder: (_) => const WatchlistMoviesPage(),
              );
            case watchlistTvRoute:
              return MaterialPageRoute(
                builder: (_) => const WatchlistTvPage(),
              );
            case detailTvSeasonRoute:
              final argument = settings.arguments as SeasonDetailArgument;
              return MaterialPageRoute(
                  builder: (_) => SeasonDetailPage(argument: argument));
            case onTheAirTvRoute:
              return MaterialPageRoute(
                builder: (_) => const OnTheAirTvPage(),
              );
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
