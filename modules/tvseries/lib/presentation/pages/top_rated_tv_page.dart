import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

class TopRatedTvPage extends StatefulWidget {
  static const routeName = '/top-rated-tv';
  const TopRatedTvPage({super.key});
  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TopRatedTvNotifier>(
        context,
        listen: false,
      ).fetchTopRatedTv(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                key: const Key('listTopRatedTv'),
                itemCount: data.tv.length,
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(
                    key: Key('listTopRatedTv$index'),
                    tv,
                  );
                },
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}