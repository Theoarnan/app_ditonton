import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

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
    Future.microtask(() => context.read<TvOnTheAirBloc>().fetchTvOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
          builder: (context, state) {
            if (state is TvOnTheAirLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvOnTheAirHasData) {
              final result = state.resultTv;
              return ListView.builder(
                key: const Key('listOnTheAirTv'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(
                    key: Key('listOnTheAirTv$index'),
                    tv,
                  );
                },
              );
            } else if (state is TvOnTheAirError) {
              return const ImageErrorEmptyStateWidget(
                key: Key('error_message'),
              );
            }
            return const ImageErrorEmptyStateWidget(
              isEmptyState: true,
              key: Key('emptyDataOnTheAirTv'),
            );
          },
        ),
      ),
    );
  }
}
