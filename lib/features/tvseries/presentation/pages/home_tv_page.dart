import 'package:app_ditonton/common/constants.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/common/widgets.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/on_the_air_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/popular_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/search_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/top_rated_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/tv_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(
      () => Provider.of<TvListNotifier>(context, listen: false)
        ..fetchOnTheAirTv()
        ..fetchPopularTv()
        ..fetchTopRatedTv(),
    );
  }

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
              Navigator.pushNamed(context, SearchTvPage.routeName);
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
                  OnTheAirTvPage.routeName,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirState;
                if (state == RequestState.loading) {
                  return const Center(
                    key: Key('loading_on_the_air'),
                    child: CircularProgressIndicator(
                      key: Key('circular_on_the_air'),
                    ),
                  );
                } else if (state == RequestState.loaded) {
                  return TvList(
                    keyList: 'ontheair',
                    key: const Key('listview_on_the_air'),
                    data.onTheAirTv,
                  );
                } else {
                  return Center(
                    key: const Key('error_message_on_the_air'),
                    child: Text(data.message),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvPage.routeName,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.loading) {
                  return const Center(
                    key: Key('loading_popular'),
                    child: CircularProgressIndicator(
                      key: Key('circular_popular'),
                    ),
                  );
                } else if (state == RequestState.loaded) {
                  return TvList(
                    keyList: 'popular',
                    key: const Key('listview_popular'),
                    data.popularTv,
                  );
                } else {
                  return Center(
                    key: const Key('error_message_popular'),
                    child: Text(data.message),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedTvPage.routeName,
                ),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedTvState;
                  if (state == RequestState.loading) {
                    return const Center(
                      key: Key('loading_top_rated'),
                      child: CircularProgressIndicator(
                        key: Key('circular_top_rated'),
                      ),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(
                      keyList: 'toprated',
                      key: const Key('listview_top_rated'),
                      data.topRatedTv,
                    );
                  } else {
                    return Center(
                      key: const Key('error_message_top_rated'),
                      child: Text(data.message),
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
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: Widgets.imageCachedNetwork(
                '$baseImageURL${tv.posterPath}',
              ),
            ),
          );
        },
      ),
    );
  }
}
