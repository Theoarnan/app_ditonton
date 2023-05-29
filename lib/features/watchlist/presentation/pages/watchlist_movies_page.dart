import 'package:app_ditonton/common/constants.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/common/utils.dart';
import 'package:app_ditonton/features/watchlist/presentation/provider/watchlist_notifier.dart';
import 'package:app_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';
  const WatchlistMoviesPage({super.key});
  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WatchlistNotifier>(
        context,
        listen: false,
      ).fetchWatchlistMovies(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistNotifier>(
      context,
      listen: false,
    ).fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              if (data.watchlistMovies.isEmpty) {
                return Center(
                  key: const Key('emptyDataWatchlistMovie'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/no-data.gif'),
                      Text(
                        'Empty data watchlist movie',
                        style: kHeading6,
                      )
                    ],
                  ),
                );
              }
              return ListView.builder(
                key: const Key('watchlistMovieScrollView'),
                itemCount: data.watchlistMovies.length,
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(
                    key: Key('watchlistMovie$index'),
                    movie,
                  );
                },
              );
            } else {
              return Center(
                key: const Key('error_message_watchlist_movie'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
