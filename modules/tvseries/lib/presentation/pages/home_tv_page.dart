import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

class HomeTvPage extends StatefulWidget {
  static const routeName = '/home-tv';
  const HomeTvPage({super.key});
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnTheAirBloc>().fetchTvOnTheAir();
      context.read<TvPopularBloc>().fetchTvPopular();
      context.read<TvTopRatedBloc>().fetchTvTopRated();
    });
  }

  Text errorText(Key key) => Text(
        key: key,
        '*Sorry, failed to load tvseries',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('drawerButtonTv'),
        title: const Text('Ditonton TV'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            key: const Key('searchButtonTv'),
            onPressed: () {
              Navigator.pushNamed(context, searchTvRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          key: const Key('tvScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () => Navigator.pushNamed(
                  context,
                  onTheAirTvRoute,
                ),
              ),
              BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
                builder: (context, state) {
                  if (state is TvOnTheAirLoading) {
                    return const Center(
                      key: Key('loading_on_the_air'),
                      child: CircularProgressIndicator(
                        key: Key('circular_on_the_air'),
                      ),
                    );
                  } else if (state is TvOnTheAirHasData) {
                    return TvList(
                      keyList: 'ontheair',
                      key: const Key('listview_on_the_air'),
                      state.resultTv,
                    );
                  } else if (state is TvOnTheAirError) {
                    return errorText(const Key('error_message_on_the_air'));
                  } else {
                    return const Text(
                      key: Key('empty_text_ontheair'),
                      '*Oops, data tv on the air is empty.',
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  popularTvRoute,
                ),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                builder: (context, state) {
                  if (state is TvPopularLoading) {
                    return const Center(
                      key: Key('loading_popular'),
                      child: CircularProgressIndicator(
                        key: Key('circular_popular'),
                      ),
                    );
                  } else if (state is TvPopularHasData) {
                    return TvList(
                      keyList: 'popular',
                      key: const Key('listview_popular'),
                      state.resultTv,
                    );
                  } else if (state is TvPopularError) {
                    return errorText(const Key('error_message_popular'));
                  } else {
                    return const Text(
                      key: Key('empty_text_popular'),
                      '*Oops, data tv popular is empty.',
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  topRatedTvRoute,
                ),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                builder: (context, state) {
                  if (state is TvTopRatedLoading) {
                    return const Center(
                      key: Key('loading_top_rated'),
                      child: CircularProgressIndicator(
                        key: Key('circular_top_rated'),
                      ),
                    );
                  } else if (state is TvTopRatedHasData) {
                    return TvList(
                      keyList: 'toprated',
                      key: const Key('listview_top_rated'),
                      state.resultTv,
                    );
                  } else if (state is TvTopRatedError) {
                    return errorText(const Key('error_message_top_rated'));
                  } else {
                    return const Text(
                      key: Key('empty_text_toprated'),
                      '*Oops, data tv top rated is empty.',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: Key('seeMore${title.replaceAll(' ', '')}Tv'),
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final String keyList;
  final List<Tv> tvseries;

  const TvList(
    this.tvseries, {
    super.key,
    required this.keyList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvseries.length,
        itemBuilder: (context, index) {
          final tv = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('$keyList${index}tv'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailTvRoute,
                  arguments: tv.id,
                );
              },
              child: Widgets.imageCachedNetworkCard(tv.posterPath),
            ),
          );
        },
      ),
    );
  }
}
