import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';
  const TopRatedMoviesPage({super.key});
  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieTopRatedBloc>(
        context,
        listen: false,
      ).fetchMoviesTopRated(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
          builder: (context, state) {
            if (state is MoviesTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieTopRatedHasData) {
              final result = state.resultMovies;
              return ListView.builder(
                key: const Key('listTopRatedMovies'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(
                    key: Key('listTopRatedMovies$index'),
                    movie,
                  );
                },
              );
            } else if (state is MoviesTopRatedError) {
              return const ImageErrorEmptyStateWidget(
                isMovieState: true,
                key: Key('error_message'),
              );
            }
            return const ImageErrorEmptyStateWidget(
              isMovieState: true,
              isEmptyState: true,
              key: Key('emptyDataTopRatedMovie'),
            );
          },
        ),
      ),
    );
  }
}
