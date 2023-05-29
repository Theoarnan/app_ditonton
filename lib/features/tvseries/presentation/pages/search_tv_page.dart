import 'package:app_ditonton/common/constants.dart';
import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_search_notifier.dart';
import 'package:app_ditonton/features/tvseries/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTvPage extends StatelessWidget {
  static const routeName = '/search-tv';
  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('enterSearchQueryTv'),
              onSubmitted: (query) {
                Provider.of<TvSearchNotifier>(
                  context,
                  listen: false,
                ).fetchTvSearch(query);
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
            Consumer<TvSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    key: Key('loading_search_tv'),
                    child: CircularProgressIndicator(
                      key: Key('circular_search_tv'),
                    ),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
                  if (result.isEmpty) {
                    return const NoDataSearchTv(
                      title: 'Search tv not found',
                    );
                  }
                  return Expanded(
                    key: const Key('list_search_tv'),
                    child: ListView.builder(
                      key: const Key('tvSearchScrollView'),
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final tv = data.searchResult[index];
                        return TvCard(
                          key: Key('listTvSearch$index'),
                          tv,
                        );
                      },
                    ),
                  );
                } else if (data.state == RequestState.error) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message_search_tv'),
                      child: Text(data.message),
                    ),
                  );
                } else {
                  return const NoDataSearchTv();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoDataSearchTv extends StatelessWidget {
  final String title;
  const NoDataSearchTv({
    super.key,
    this.title = 'Search tv',
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          key: const Key('emptyDataSearchTv'),
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
