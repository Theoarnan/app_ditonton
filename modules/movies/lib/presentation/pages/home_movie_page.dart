import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/provider/movie_list_notifier.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  static const routeName = '/home-movie';
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ditonton Movie'),
        key: const Key('drawerButtonMovie'),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            key: const Key('searchButtonMovie'),
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return MovieList(
                    keyList: 'nowplaying',
                    data.nowPlayingMovies,
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  popularMovieRoute,
                ),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return MovieList(
                    keyList: 'popular',
                    data.popularMovies,
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  topRatedMovieRoute,
                ),
              ),
              Consumer<MovieListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedMoviesState;
                  if (state == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return MovieList(
                      keyList: 'toprated',
                      data.topRatedMovies,
                    );
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: Key('seeMore${title.replaceAll(' ', '')}Movies'),
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

class MovieList extends StatelessWidget {
  final String keyList;
  final List<Movie> movies;

  const MovieList(
    this.movies, {
    super.key,
    required this.keyList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        key: Key(keyList),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('$keyList$index'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  detailMovieRoute,
                  arguments: movie.id,
                );
              },
              child: Widgets.imageCachedNetworkCard(movie.posterPath),
            ),
          );
        },
      ),
    );
  }
}