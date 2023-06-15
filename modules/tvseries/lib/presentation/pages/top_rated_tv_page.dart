import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Future.microtask(() => context.read<TvTopRatedBloc>().fetchTvTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedHasData) {
              final result = state.resultTv;
              return ListView.builder(
                key: const Key('listTopRatedTv'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(
                    key: Key('listTopRatedTv$index'),
                    tv,
                  );
                },
              );
            } else if (state is TvTopRatedError) {
              return const ImageErrorEmptyStateWidget(
                key: Key('error_message'),
              );
            }
            return const ImageErrorEmptyStateWidget(
              isEmptyState: true,
              key: Key('emptyDataTopRatedTv'),
            );
          },
        ),
      ),
    );
  }
}
