// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/provider/movie_detail_notifier.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/detail-movie';
  final int id;
  const MovieDetailPage({super.key, required this.id});
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieDetailNotifier>(
        context,
        listen: false,
      ).fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(
        context,
        listen: false,
      ).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.movieState == RequestState.loaded) {
            final movie = provider.movie;
            return SafeArea(
              key: const Key('content_detail_movie'),
              child: DetailContent(
                movie,
                provider.movieRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Center(
              key: const Key('error_message_detail_movie'),
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
    this.movie,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageURL${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                key: const Key('movieDetailScrollView'),
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              key: const Key('moveButtonWatchlist'),
                              onPressed: () => handleOnTapButton(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(movie.genres)),
                            Text(_showDuration(movie.runtime)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(formatVoteAverage(movie.voteAverage))
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(movie.overview),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<MovieDetailNotifier>(
                              builder: (context, data, child) {
                                final state = data.recommendationState;
                                if (state == RequestState.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state == RequestState.error) {
                                  return Center(
                                    key: const Key('error_message_2'),
                                    child: Text(data.message),
                                  );
                                } else if (state == RequestState.loaded) {
                                  return SizedBox(
                                    key: const Key(
                                      'content_movie_detail_recommendation',
                                    ),
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key(
                                        'list_builder_recomendation',
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.routeName,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: cardRecomendation(movie),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    key: Key('empty_widget'),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('buttonBackDetailMovie'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget cardRecomendation(Movie movie) {
    return Widgets.imageCachedNetworkCard(movie.posterPath);
  }

  Future<void> handleOnTapButton(BuildContext context) async {
    if (!isAddedWatchlist) {
      await Provider.of<MovieDetailNotifier>(
        context,
        listen: false,
      ).addWatchlist(
        movie,
      );
    } else {
      await Provider.of<MovieDetailNotifier>(
        context,
        listen: false,
      ).removeFromWatchlist(
        movie,
      );
    }

    final message = Provider.of<MovieDetailNotifier>(
      context,
      listen: false,
    ).watchlistMessage;

    if (message == MovieDetailNotifier.watchlistAddSuccessMessage ||
        message == MovieDetailNotifier.watchlistRemoveSuccessMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    }
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }
    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}