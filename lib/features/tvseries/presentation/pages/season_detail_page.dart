import 'package:app_ditonton/common/constants.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/common/utils.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/episode.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail_argument.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/season_detail_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class SeasonDetailPage extends StatefulWidget {
  static const routeName = '/season-detail';
  final SeasonDetailArgument argument;
  const SeasonDetailPage({
    super.key,
    required this.argument,
  });

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<SeasonDetailNotifier>(
          context,
          listen: false,
        ).fetchSeasonDetail(
          id: widget.argument.id,
          seasonNumber: widget.argument.season.seasonNumber,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SeasonDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.seasonState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.seasonState == RequestState.loaded) {
            final season = provider.seasonDetail;
            return SafeArea(
              key: const Key('content_detail_season'),
              child: DetailContent(
                season: widget.argument.season,
                seasonDetail: season,
              ),
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final Season season;
  final SeasonDetail seasonDetail;

  const DetailContent({
    super.key,
    required this.season,
    required this.seasonDetail,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imageDetail = '$baseImageURL${seasonDetail.posterPath}';
    final imageUse =
        checkIsEmpty(seasonDetail.posterPath) ? imageLoadingURL : imageDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imageUse,
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight * 0.26,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: kRichBlack,
                foregroundColor: Colors.white,
                child: IconButton(
                  key: const Key('buttonBackSeasonDetailTv'),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                season.name,
                style: kHeading5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kMikadoYellow,
                ),
              ),
              Text('Total Episode ${season.episodeCount}', style: kBodyText),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Episodes',
                  style: kHeading6,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    key: const Key('listSeasonEpisodeTv'),
                    separatorBuilder: (context, index) => Divider(
                      key: Key('divider_content_detail_season$index'),
                    ),
                    itemCount: seasonDetail.episodes.length,
                    itemBuilder: (context, index) {
                      final episode = seasonDetail.episodes[index];
                      return ListTileEpisode(
                        key: Key('listSeasonEpisodeTv$index'),
                        screenWidth: screenWidth,
                        episode: episode,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ListTileEpisode extends StatelessWidget {
  const ListTileEpisode({
    super.key,
    required this.screenWidth,
    required this.episode,
  });

  final double screenWidth;
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final imageEpisodeDetail = '$baseImageURL${episode.stillPath!}';
    final imageUse =
        checkIsEmpty(episode.stillPath) ? imageLoadingURL : imageEpisodeDetail;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 70,
                  child: CachedNetworkImage(
                    imageUrl: imageUse,
                    placeholder: (_, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const SizedBox(
                      height: 100,
                      width: 70,
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Episode ${episode.episodeNumber}',
                      style: kBodyText.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        episode.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kBodyText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kMikadoYellow,
                        ),
                      ),
                    ),
                    if (!checkIsEmpty(episode.airDate))
                      Text(
                        formatDate(episode.airDate!),
                        style: kBodyText.copyWith(
                          fontSize: 10,
                          color: Colors.grey.shade300,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (episode.overview.isNotEmpty)
            ReadMoreText(
              episode.overview,
              style: kBodyText,
              trimLines: 2,
              colorClickableText: kMikadoYellow,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              moreStyle: kBodyText.copyWith(
                color: kMikadoYellow,
              ),
            )
        ],
      ),
    );
  }
}
