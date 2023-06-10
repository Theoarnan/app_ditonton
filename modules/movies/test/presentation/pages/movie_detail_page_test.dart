import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.dart';

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieRecomendationBloc movieRecomendationBloc;

  setUpAll(() {
    // movie now playing
    movieDetailBloc = MockMovieDetailBloc();
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    // movie popular
    movieRecomendationBloc = MockMovieRecomendationBloc();
    registerFallbackValue(MockMovieRecomendationState());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => movieDetailBloc,
          ),
          BlocProvider(
            create: (_) => movieRecomendationBloc,
          ),
        ],
        child: body,
      ),
    );
  }

  group('Movie detail page test', () {
    group('detail movie', () {
      testWidgets(
          'should display loading content when state loading detail movie', (
        WidgetTester tester,
      ) async {
        when(() => movieDetailBloc.state).thenReturn(MovieDetailLoading());
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationLoading(),
        );

        final loadingDetailFinder = find.byKey(
          const Key('center_loading_detail'),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(loadingDetailFinder, findsOneWidget);
      });

      testWidgets('should display detail content when data is loaded',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationLoading(),
        );

        final contentDetailFinder =
            find.byKey(const Key('content_detail_movie'));
        final loadingDetailRecomendationFinder = find.byKey(
          const Key('center_loading_recomendation'),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentDetailFinder, findsOneWidget);
        expect(loadingDetailRecomendationFinder, findsOneWidget);
      });

      testWidgets(
          'should display text with message when error detail page movie',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(MovieDetailError('Error'));
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationLoading(),
        );

        final contentErrorFinder =
            find.byKey(const Key('error_message_detail_movie'));

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentErrorFinder, findsOneWidget);
      });

      testWidgets('should display nothing when state empty detail page movie',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(MovieDetailEmpty());
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationLoading(),
        );

        final contentEmptyFinder = find.byType(SizedBox);

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentEmptyFinder, findsOneWidget);
      });
    });

    testWidgets(
        'watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
      when(() => movieRecomendationBloc.state).thenReturn(
        MovieRecomendationHasData(tMovieList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'watchlist button should display add icon when movie is added to watchlist',
        (WidgetTester tester) async {
      when(() => movieDetailBloc.state)
          .thenReturn(tMovieDetailHasDataStateTrue);
      when(() => movieRecomendationBloc.state).thenReturn(
        MovieRecomendationHasData(tMovieList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
      'should display watchlist update status when add watchlist movie is success',
      (tester) async {
        final states = [
          tMovieDetailHasDataState.changeAttr(
            isActiveWatchlist: true,
            watchlistMessage: 'Added to Watchlist',
          ),
        ];
        when(() => movieDetailBloc.state).thenAnswer(
          (_) => tMovieDetailHasDataState,
        );
        whenListen(movieDetailBloc, Stream.fromIterable(states));
        when(() => movieRecomendationBloc.state).thenReturn(
          MovieRecomendationHasData(tMovieList),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(find.byIcon(Icons.add), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      },
    );

    testWidgets(
      'should display watchlist update status when remove movie from watchlist is success',
      (tester) async {
        final states = [
          tMovieDetailHasDataState.changeAttr(
            isActiveWatchlist: false,
            watchlistMessage: 'Removed from Watchlist',
          ),
        ];
        when(() => movieDetailBloc.state).thenAnswer((_) =>
            tMovieDetailHasDataState.changeAttr(isActiveWatchlist: true));
        whenListen(movieDetailBloc, Stream.fromIterable(states));
        when(() => movieRecomendationBloc.state).thenReturn(
          MovieRecomendationHasData(tMovieList),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));
        expect(find.byIcon(Icons.check), findsOneWidget);
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
      },
    );

    testWidgets(
      'should display alertDialog when add movie to watchlist is failed',
      (tester) async {
        final states = [
          tMovieDetailHasDataState.changeAttr(
            watchlistMessage: 'Database Failure',
          ),
        ];
        when(() => movieDetailBloc.state).thenAnswer(
          (_) => tMovieDetailHasDataState,
        );
        whenListen(movieDetailBloc, Stream.fromIterable(states));
        when(() => movieRecomendationBloc.state).thenReturn(
          MovieRecomendationHasData(tMovieList),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(find.byIcon(Icons.add), findsOneWidget);
        await tester.pump();
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Database Failure'), findsOneWidget);
      },
    );

    group('recomendation movie', () {
      testWidgets(
          'should display loading content when state loading detail movie recomendation',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationLoading(),
        );

        final loadingDetailRecomendationFinder = find.byKey(
          const Key('center_loading_recomendation'),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(loadingDetailRecomendationFinder, findsOneWidget);
      });

      testWidgets(
          'should display detail content and display recoemndstion movie when data is loaded',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
        when(() => movieRecomendationBloc.state).thenReturn(
          MovieRecomendationHasData(tMovieList),
        );

        final contentDetailFinder =
            find.byKey(const Key('content_detail_movie'));
        final contentDetailRecomendationFinder = find.byKey(
          const Key('content_movie_detail_recommendation'),
        );
        final contentDetailRecomendationListFinder = find.byKey(
          const Key('list_builder_recomendation'),
        );

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentDetailFinder, findsOneWidget);
        expect(contentDetailRecomendationFinder, findsOneWidget);
        expect(contentDetailRecomendationListFinder, findsOneWidget);
      });

      testWidgets(
          'should display text with message when error recomendations movie',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
        when(() => movieRecomendationBloc.state).thenReturn(
          const MoviesRecomendationError('Error'),
        );

        final contentDetailFinder =
            find.byKey(const Key('content_detail_movie'));
        final contentErrorRecomendationFinder =
            find.byKey(const Key('error_message_2'));
        final contentErrorRecomendationTextFinder =
            find.text('Sorry, failed to load recomendation movies.');

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentDetailFinder, findsOneWidget);
        expect(contentErrorRecomendationFinder, findsOneWidget);
        expect(contentErrorRecomendationTextFinder, findsOneWidget);
      });

      testWidgets(
          'should display nothing when state empty recomendation detail page movie',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state).thenReturn(tMovieDetailHasDataState);
        when(() => movieRecomendationBloc.state).thenReturn(
          MoviesRecomendationEmpty(),
        );

        final contentDetailFinder =
            find.byKey(const Key('content_detail_movie'));
        final contentEmptyFinder = find.byKey(
          const Key('empty_widget'),
        );
        final contentEmptyRecomendationTextFinder =
            find.text('Oops, Recomendation movies is empty.');

        await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
          id: 1,
        )));

        expect(contentDetailFinder, findsOneWidget);
        expect(contentEmptyFinder, findsOneWidget);
        expect(contentEmptyRecomendationTextFinder, findsOneWidget);
      });
    });
  });
}
