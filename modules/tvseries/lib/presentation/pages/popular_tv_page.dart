import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular-tv';
  const PopularTvPage({super.key});
  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvPopularBloc>().fetchTvPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularHasData) {
              final result = state.resultTv;
              return ListView.builder(
                key: const Key('listPopularTv'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(
                    key: Key('listPopularTv$index'),
                    tv,
                  );
                },
              );
            } else if (state is TvPopularError) {
              return const ImageErrorEmptyStateWidget(
                key: Key('error_message'),
              );
            }
            return const ImageErrorEmptyStateWidget(
              isEmptyState: true,
              key: Key('emptyDataPopularTv'),
            );
          },
        ),
      ),
    );
  }
}
