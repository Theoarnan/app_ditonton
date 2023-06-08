import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/presentation/bloc/watchlist_bloc.dart';

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
      () => Provider.of<WatchlistBloc>(
        context,
        listen: false,
      ).add(FetchWatchlistMovies()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistBloc>(
      context,
      listen: false,
    ).add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieHasData) {
              final result = state.resultMovies;
              return ListView.builder(
                key: const Key('watchlistMovieScrollView'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(
                    key: Key('watchlistMovie$index'),
                    movie,
                  );
                },
              );
            } else if (state is WatchlistError) {
              return Center(
                key: const Key('error_message_watchlist_movie'),
                child: Text(state.message),
              );
            } else if (state is WatchlistEmpty) {
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
            return const SizedBox.shrink();
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
