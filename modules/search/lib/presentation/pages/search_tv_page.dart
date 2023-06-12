import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

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
              onChanged: (query) {
                context.read<SearchBloc>().add(OnQueryChangedTv(query));
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
                    key: Key('loading_search_tv'),
                    child: CircularProgressIndicator(
                      key: Key('circular_search_tv'),
                    ),
                  );
                } else if (state is SearchTvHasData) {
                  final result = state.resultTv;
                  return Expanded(
                    key: const Key('list_search_tv'),
                    child: ListView.builder(
                      key: const Key('tvSearchScrollView'),
                      padding: const EdgeInsets.all(8),
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvCard(
                          key: Key('listTvSearch$index'),
                          tv,
                        );
                      },
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      key: const Key('error_message_search_tv'),
                      child: Text(state.message),
                    ),
                  );
                } else if (state is SearchEmpty) {
                  return const NoDataSearchTv(
                    title: 'Search tv not found',
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
