import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';

class SearchMoviePage extends StatelessWidget {
  static const routeName = '/search-movie';
  const SearchMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('enterSearchQueryMovie'),
              onChanged: (query) {
                context.read<SearchBloc>().add(OnQueryChangedMovie(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    key: Key('loading_search_movie'),
                    child: CircularProgressIndicator(
                      key: Key('circular_search_movie'),
                    ),
                  );
                } else if (state is SearchMovieHasData) {
                  final result = state.resultMovies;
                  return Expanded(
                    key: const Key('list_search_movie'),
                    child: ListView.builder(
                      key: const Key('movieSearchScrollView'),
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(
                          key: Key('listMovieSearch$index'),
                          movie,
                        );
                      },
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message_search_movie'),
                      child: Text(state.message),
                    ),
                  );
                } else if (state is SearchEmpty) {
                  return const NoDataSearchMovie(
                    title: 'Search movie not found',
                  );
                } else {
                  return const NoDataSearchMovie();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoDataSearchMovie extends StatelessWidget {
  final String title;
  const NoDataSearchMovie({
    super.key,
    this.title = 'Search movie',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          key: const Key('emptyDataSearchMovie'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/no-data.gif'),
              Text(
                title,
                style: kHeading6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
