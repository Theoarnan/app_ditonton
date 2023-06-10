import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';
  const PopularMoviesPage({super.key});
  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MoviePopularBloc>(
        context,
        listen: false,
      ).fetchMoviesPopular(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if (state is MoviesPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              final result = state.resultMovies;
              return ListView.builder(
                key: const Key('listPopularMovies'),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(
                    key: Key('listPopularMovies$index'),
                    movie,
                  );
                },
              );
            } else if (state is MoviesPopularError) {
              return const ImageErrorEmptyStateWidget(
                isMovieState: true,
                key: Key('error_message'),
              );
            }
            return const ImageErrorEmptyStateWidget(
              isMovieState: true,
              isEmptyState: true,
              key: Key('emptyDataPopularMovie'),
            );
          },
        ),
      ),
    );
  }
}
