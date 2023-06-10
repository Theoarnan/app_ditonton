import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
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
      () {
        Provider.of<MovieNowPlayingBloc>(
          context,
          listen: false,
        ).fetchMoviesNowPlaying();
        Provider.of<MoviePopularBloc>(
          context,
          listen: false,
        ).fetchMoviesPopular();
        Provider.of<MovieTopRatedBloc>(
          context,
          listen: false,
        ).fetchMoviesTopRated();
      },
    );
  }

  Text errorText(Key key) => Text(
        key: key,
        '*Sorry, failed to load movies',
      );

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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
                  if (state is MoviesNowPlayingLoading) {
                    return const Center(
                      key: Key('loading_nowplaying'),
                      child: CircularProgressIndicator(
                        key: Key('circular_nowplaying'),
                      ),
                    );
                  } else if (state is MovieNowPlayingHasData) {
                    return MovieList(
                      keyList: 'nowplaying',
                      state.resultMovies,
                    );
                  } else if (state is MoviesNowPlayingError) {
                    return errorText(const Key('error_message_nowplaying'));
                  }
                  return const Text(
                    key: Key('empty_text_nowplaying'),
                    '*Oops, data movies now playing is empty.',
                  );
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  popularMovieRoute,
                ),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
                  if (state is MoviesPopularLoading) {
                    return const Center(
                      key: Key('loading_popular'),
                      child: CircularProgressIndicator(
                        key: Key('circular_popular'),
                      ),
                    );
                  } else if (state is MoviePopularHasData) {
                    return MovieList(
                      keyList: 'popular',
                      state.resultMovies,
                    );
                  } else if (state is MoviesPopularError) {
                    return errorText(const Key('error_message_popular'));
                  }
                  return const Text(
                    key: Key('empty_text_popular'),
                    '*Oops, data popular movies is empty.',
                  );
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  topRatedMovieRoute,
                ),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
                  if (state is MoviesTopRatedLoading) {
                    return const Center(
                      key: Key('loading_toprated'),
                      child: CircularProgressIndicator(
                        key: Key('circular_toprated'),
                      ),
                    );
                  } else if (state is MovieTopRatedHasData) {
                    return MovieList(
                      keyList: 'toprated',
                      state.resultMovies,
                    );
                  } else if (state is MoviesTopRatedError) {
                    return errorText(const Key('error_message_toprated'));
                  }
                  return const Text(
                    key: Key('empty_text_toprated'),
                    '*Oops, data top rated movies is empty.',
                  );
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
