import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';

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
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(
                  context,
                  listen: false,
                ).fetchMovieSearch(query);
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
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    key: Key('loading_search_movie'),
                    child: CircularProgressIndicator(
                      key: Key('circular_search_movie'),
                    ),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
                  if (result.isEmpty) {
                    return const NoDataSearchMovie(
                      title: 'Search movie not found',
                    );
                  }
                  return Expanded(
                    key: const Key('list_search_movie'),
                    child: ListView.builder(
                      key: const Key('movieSearchScrollView'),
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final movie = data.searchResult[index];
                        return MovieCard(
                          key: Key('listMovieSearch$index'),
                          movie,
                        );
                      },
                    ),
                  );
                } else if (data.state == RequestState.error) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message_search_movie'),
                      child: Text(data.message),
                    ),
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
