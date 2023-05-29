import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/on_the_air_tv_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const routeName = '/ontheair-tv';
  const OnTheAirTvPage({super.key});
  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<OnTheAirTvNotifier>(
        context,
        listen: false,
      ).fetchOnTheAirTv(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                key: const Key('listOnTheAirTv'),
                itemBuilder: (context, index) {
                  final tv = data.tv[index];
                  return TvCard(
                    key: Key('listOnTheAirTv$index'),
                    tv,
                  );
                },
                itemCount: data.tv.length,
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
