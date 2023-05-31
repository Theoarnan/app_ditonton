import 'package:app_ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:app_ditonton/data/repositories/movie_repository_impl.dart';
import 'package:app_ditonton/domain/repositories/movie_repository.dart';
import 'package:app_ditonton/domain/usecases/get_movie_detail.dart';
import 'package:app_ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:app_ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:app_ditonton/domain/usecases/get_popular_movies.dart';
import 'package:app_ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:app_ditonton/domain/usecases/search_movies.dart';
import 'package:app_ditonton/features/tvseries/data/datasources/tv_remote_data_source.dart';
import 'package:app_ditonton/features/tvseries/data/repositories/tv_repository_impl.dart';
import 'package:app_ditonton/features/tvseries/domain/repositories/tv_repository.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_on_the_air_tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_popular_tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_top_rated_tv.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/get_tv_recommendations.dart';
import 'package:app_ditonton/features/tvseries/domain/usecases/search_tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/on_the_air_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/populer_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/season_detail_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/top_rated_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_detail_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_search_notifier.dart';
import 'package:app_ditonton/features/watchlist/data/datasources/db/database_helper.dart';
import 'package:app_ditonton/features/watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:app_ditonton/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:app_ditonton/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_tv.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/remove_watchlist_movie.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/remove_watchlist_tv.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/save_watchlist_movie.dart';
import 'package:app_ditonton/features/watchlist/domain/usecases/save_watchlist_tv.dart';
import 'package:app_ditonton/features/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:app_ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:app_ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:app_ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:app_ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:app_ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonDetailNotifier(
      getSeasonDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
      getWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvNotifier(
      getOnTheAirTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
