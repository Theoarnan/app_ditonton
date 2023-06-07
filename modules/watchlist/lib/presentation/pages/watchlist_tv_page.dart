import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/presentation/provider/watchlist_notifier.dart';

class WatchlistTvPage extends StatefulWidget {
  static const routeName = '/watchlist-tv';
  const WatchlistTvPage({super.key});
  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WatchlistNotifier>(
        context,
        listen: false,
      ).fetchWatchlistTv(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
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
              if (data.watchlistTv.isEmpty) {
                return Center(
                  key: const Key('emptyDataWatchlistTv'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/no-data.gif'),
                      Text(
                        'Empty data watchlist tv',
                        style: kHeading6,
                      )
                    ],
                  ),
                );
              }
              return ListView.builder(
                key: const Key('watchlistTvScrollView'),
                itemBuilder: (context, index) {
                  final tv = data.watchlistTv[index];
                  return TvCard(
                    key: Key('watchlistTv$index'),
                    tv,
                  );
                },
                itemCount: data.watchlistTv.length,
              );
            } else {
              return Center(
                key: const Key('error_message_watchlist_movie_tv'),
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
