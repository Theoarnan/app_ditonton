import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';
import 'package:watchlist/watchlist.dart';

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
      () => Provider.of<WatchlistBloc>(
        context,
        listen: false,
      ).add(FetchWatchlistTv()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistBloc>(context, listen: false).add(
      FetchWatchlistTv(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvHasData) {
              final result = state.resultTv;
              return ListView.builder(
                key: const Key('watchlistTvScrollView'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(
                    key: Key('watchlistTv$index'),
                    tv,
                  );
                },
              );
            } else if (state is WatchlistError) {
              return Center(
                key: const Key('error_message_watchlist_movie_tv'),
                child: Text(state.message),
              );
            } else if (state is WatchlistEmpty) {
              return Center(
                key: const Key('emptyDataWatchlistTv'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(emptyDataAsset),
                    Text(
                      'Empty data watchlist tv',
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
