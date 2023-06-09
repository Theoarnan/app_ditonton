// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/movies.dart';
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
      Provider.of<MovieDetailBloc>(
        context,
        listen: false,
      ).add(FetchMovieDetail(idMovie: widget.id));
      Provider.of<MovieRecomendationBloc>(
        context,
        listen: false,
      ).fetchMoviesRecomendation(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state is MovieDetailHasData &&
              state.watchlistMessage.isNotEmpty) {
            final message = state.watchlistMessage;
            if (message == 'Added to Watchlist' ||
                message == 'Removed from Watchlist') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text(message));
                },
              );
            }
          }
        },
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              key: Key('center_loading_detail'),
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.movieDetail;
            return SafeArea(
              key: const Key('content_detail_movie'),
              child: DetailContent(
                movie,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state is MovieDetailError) {
            return const ImageErrorEmptyStateWidget(
              key: Key('error_message_detail_movie'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  const DetailContent(
    this.movie,
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
                              onPressed: () => handleOnTapButton(
                                context,
                                isAddedWatchlist,
                              ),
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
                            handleBlocRecomendationMovie(),
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

  handleBlocRecomendationMovie() {
    return BlocBuilder<MovieRecomendationBloc, MovieRecomendationState>(
      builder: (context, state) {
        if (state is MoviesRecomendationLoading) {
          return const Center(
            key: Key('center_loading_recomendation'),
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieRecomendationHasData) {
          final result = state.resultMovies;
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
              itemCount: result.length,
              itemBuilder: (context, index) {
                final movie = result[index];
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
                    child: Widgets.imageCachedNetworkCard(movie.posterPath),
                  ),
                );
              },
            ),
          );
        } else if (state is MoviesRecomendationError) {
          return const Text(
            key: Key('error_message_2'),
            'Sorry, failed to load recomendation movies.',
          );
        } else {
          return const Text(
            key: Key('empty_widget'),
            'Oops, Recomendation movies is empty.',
          );
        }
      },
    );
  }

  Future<void> handleOnTapButton(
    BuildContext context,
    bool isAddedWatchlist,
  ) async {
    final blocMovieDetail = context.read<MovieDetailBloc>();
    if (!isAddedWatchlist) return blocMovieDetail.add(AddToWatchlistMovie());
    return blocMovieDetail.add(RemoveFromWatchlistMovie());
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
