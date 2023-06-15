import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/tvseries.dart';

class TvDetailPage extends StatefulWidget {
  static const routeName = '/detail-tv';
  final int id;
  const TvDetailPage({super.key, required this.id});
  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(idTvseries: widget.id));
      context.read<TvRecomendationBloc>().fetchTvRecomendation(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvDetailBloc, TvDetailState>(
        listener: (context, state) {
          if (state is TvDetailHasData && state.watchlistMessage.isNotEmpty) {
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
          if (state is TvDetailLoading) {
            return const Center(
              key: Key('center_loading_detail'),
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            return SafeArea(
              key: const Key('content_detail_tv'),
              child: ContentDetailTv(
                state.tvDetail,
                isAddedWatchlist: state.isAddedToWatchlist,
              ),
            );
          } else if (state is TvDetailError) {
            return const ImageErrorEmptyStateWidget(
              key: Key('error_message_detail_tv'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class ContentDetailTv extends StatelessWidget {
  final TvDetail tvDetail;
  final bool isAddedWatchlist;

  const ContentDetailTv(
    this.tvDetail, {
    super.key,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageDetailPoster = '$baseImageURL${tvDetail.posterPath}';
    final imageUse =
        checkIsEmpty(tvDetail.posterPath) ? imageLoadingURL : imageDetailPoster;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUse,
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.error,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return Container(
                key: const Key('tvDetailScrollView'),
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tvDetail.name, style: kHeading5),
                            ElevatedButton(
                              key: const Key('tvButtonWatchlist'),
                              onPressed: () => handleOnTapButtonWatchlist(
                                context,
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
                            const SizedBox(height: 8),
                            Text(_showGenres(tvDetail.genres)),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(formatVoteAverage(tvDetail.voteAverage))
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(tvDetail.overview.isNotEmpty
                                ? tvDetail.overview
                                : 'No Description'),
                            const SizedBox(height: 16),
                            if (tvDetail.seasons.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Seasons', style: kHeading6),
                                  SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key(
                                        'seasonTvDetailScrollView',
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tvDetail.seasons.length,
                                      itemBuilder: (context, index) {
                                        final season = tvDetail.seasons[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            key: Key('seasonList$index'),
                                            onTap: () => Navigator.pushNamed(
                                              context,
                                              detailTvSeasonRoute,
                                              arguments: SeasonDetailArgument(
                                                id: tvDetail.id,
                                                season: season,
                                              ),
                                            ),
                                            child: cardSeason(season),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            handleRecomendationState(),
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
              key: const Key('buttonBackDetailTv'),
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

  BlocBuilder<TvRecomendationBloc, TvRecomendationState>
      handleRecomendationState() {
    return BlocBuilder<TvRecomendationBloc, TvRecomendationState>(
      builder: (context, state) {
        if (state is TvRecomendationLoading) {
          return const Center(
            key: Key('center_loading_recomendation'),
            child: CircularProgressIndicator(),
          );
        } else if (state is TvRecomendationHasData) {
          final result = state.resultTv;
          return Column(
            children: [
              SizedBox(
                key: const Key(
                  'content_detail_recommendation',
                ),
                height: 150,
                child: ListView.builder(
                  key: const Key(
                    'recomendationTvDetailScrollView',
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: result.length,
                  itemBuilder: (context, i) {
                    final tv = result[i];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        key: Key('recomendation${i}tv'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            TvDetailPage.routeName,
                            arguments: tv.id,
                          );
                        },
                        child: Widgets.imageCachedNetworkCard(tv.posterPath),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is TvRecomendationError) {
          return const Text(
            key: Key('error_message_recomendation'),
            'Sorry, failed to load recomendation tvseries.',
          );
        } else {
          return const Text(
            key: Key('empty_widget_tv'),
            'Oops, Recomendation tvseries is empty.',
          );
        }
      },
    );
  }

  Widget cardSeason(Season season) {
    return Widgets.imageCachedNetworkCard(season.posterPath);
  }

  Future<void> handleOnTapButtonWatchlist(BuildContext context) async {
    final blocTvDetail = context.read<TvDetailBloc>();
    if (!isAddedWatchlist) return blocTvDetail.add(AddToWatchlistTv());
    return blocTvDetail.add(RemoveFromWatchlistTv());
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
}
