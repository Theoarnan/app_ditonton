// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:tvseries/tvseries.dart';

// import '../../test_helper/dummy_data.dart';
// import '../../test_helper/navigiation.dart';
// import '../../test_helper/test_helper_tvseries.mocks.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late TvRecomendationBloc tvRecomendationBloc;

  setUpAll(() {
    tvDetailBloc = MockTvDetailBloc();
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    tvRecomendationBloc = MockTvRecomendationBloc();
    registerFallbackValue(MockTvRecomendationBloc());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => tvDetailBloc,
          ),
          BlocProvider(
            create: (_) => tvRecomendationBloc,
          ),
        ],
        child: body,
      ),
    );
  }

  group('Tv detail page test', () {
    group('detail tv', () {
      testWidgets(
          'should display loading content when state loading detail tvseries', (
        WidgetTester tester,
      ) async {
        when(() => tvDetailBloc.state).thenReturn(TvDetailLoading());
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationLoading(),
        );

        final loadingDetailFinder = find.byKey(
          const Key('center_loading_detail'),
        );

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
          id: 1,
        )));

        expect(loadingDetailFinder, findsOneWidget);
      });

      testWidgets('should display detail content when data is loaded',
          (WidgetTester tester) async {
        when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationLoading(),
        );

        final contentDetailFinder = find.byKey(const Key('content_detail_tv'));
        final loadingDetailRecomendationFinder = find.byKey(
          const Key('center_loading_recomendation'),
        );

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
          id: 1,
        )));

        expect(contentDetailFinder, findsOneWidget);
        expect(loadingDetailRecomendationFinder, findsOneWidget);
      });

      testWidgets(
          'should display text with message when error detail page tvseries',
          (WidgetTester tester) async {
        when(() => tvDetailBloc.state).thenReturn(TvDetailError('Error'));
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationLoading(),
        );

        final contentErrorFinder =
            find.byKey(const Key('error_message_detail_tv'));

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
          id: 1,
        )));

        expect(contentErrorFinder, findsOneWidget);
      });

      testWidgets(
          'should display nothing when state empty detail page tvseries',
          (WidgetTester tester) async {
        when(() => tvDetailBloc.state).thenReturn(TvDetailEmpty());
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationLoading(),
        );

        final contentEmptyFinder = find.byType(SizedBox);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
          id: 1,
        )));

        expect(contentEmptyFinder, findsOneWidget);
      });

      testWidgets(
          'watchlist button should display add icon when tvseries not added to watchlist',
          (WidgetTester tester) async {
        when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationHasData(tTvList),
        );

        final watchlistButtonIcon = find.byIcon(Icons.add);
        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
        expect(watchlistButtonIcon, findsOneWidget);
      });

      testWidgets(
          'watchlist button should display add icon when tvseries is added to watchlist',
          (WidgetTester tester) async {
        when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataStateTrue);
        when(() => tvRecomendationBloc.state).thenReturn(
          TvRecomendationHasData(tTvList),
        );

        final watchlistButtonIcon = find.byIcon(Icons.check);
        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
        expect(watchlistButtonIcon, findsOneWidget);
      });

      testWidgets(
        'should display watchlist update status when add watchlist tvseries is success',
        (tester) async {
          final states = [
            tTvDetailHasDataState.changeAttr(
              isActiveWatchlist: true,
              watchlistMessage: 'Added to Watchlist',
            ),
          ];
          when(() => tvDetailBloc.state).thenAnswer(
            (_) => tTvDetailHasDataState,
          );
          whenListen(tvDetailBloc, Stream.fromIterable(states));
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationHasData(tTvList),
          );

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
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
        'should display watchlist update status when remove tvseries from watchlist is success',
        (tester) async {
          final states = [
            tTvDetailHasDataState.changeAttr(
              isActiveWatchlist: false,
              watchlistMessage: 'Removed from Watchlist',
            ),
          ];
          when(() => tvDetailBloc.state).thenAnswer(
              (_) => tTvDetailHasDataState.changeAttr(isActiveWatchlist: true));
          whenListen(tvDetailBloc, Stream.fromIterable(states));
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationHasData(tTvList),
          );

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
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
        'should display alertDialog when add tvseries to watchlist is failed',
        (tester) async {
          final states = [
            tTvDetailHasDataState.changeAttr(
              watchlistMessage: 'Database Failure',
            ),
          ];
          when(() => tvDetailBloc.state).thenAnswer(
            (_) => tTvDetailHasDataState,
          );
          whenListen(tvDetailBloc, Stream.fromIterable(states));
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationHasData(tTvList),
          );

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
            id: 1,
          )));

          expect(find.byIcon(Icons.add), findsOneWidget);
          await tester.pump();
          expect(find.byIcon(Icons.add), findsOneWidget);
          expect(find.byType(AlertDialog), findsOneWidget);
          expect(find.text('Database Failure'), findsOneWidget);
        },
      );

      group('recomendation tvseries', () {
        testWidgets(
            'should display loading content when state loading detail tvseries recomendation',
            (WidgetTester tester) async {
          when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationLoading(),
          );

          final loadingDetailRecomendationFinder = find.byKey(
            const Key('center_loading_recomendation'),
          );

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
            id: 1,
          )));

          expect(loadingDetailRecomendationFinder, findsOneWidget);
        });

        testWidgets(
            'should display detail content and display recoemndstion tvseries when data is loaded',
            (WidgetTester tester) async {
          when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationHasData(tTvList),
          );

          final contentDetailFinder =
              find.byKey(const Key('content_detail_tv'));
          final contentDetailRecomendationFinder = find.byKey(
            const Key('content_detail_recommendation'),
          );
          final contentDetailRecomendationListFinder = find.byKey(
            const Key('recomendationTvDetailScrollView'),
          );

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
            id: 1,
          )));

          expect(contentDetailFinder, findsOneWidget);
          expect(contentDetailRecomendationFinder, findsOneWidget);
          expect(contentDetailRecomendationListFinder, findsOneWidget);
        });

        testWidgets(
            'should display text with message when error recomendations tvseries',
            (WidgetTester tester) async {
          when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
          when(() => tvRecomendationBloc.state).thenReturn(
            const TvRecomendationError('Error'),
          );

          final contentDetailFinder =
              find.byKey(const Key('content_detail_tv'));
          final contentErrorRecomendationFinder =
              find.byKey(const Key('error_message_recomendation'));
          final contentErrorRecomendationTextFinder =
              find.text('Sorry, failed to load recomendation tvseries.');

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
            id: 1,
          )));

          expect(contentDetailFinder, findsOneWidget);
          expect(contentErrorRecomendationFinder, findsOneWidget);
          expect(contentErrorRecomendationTextFinder, findsOneWidget);
        });

        testWidgets(
            'should display nothing when state empty recomendation detail page tvseries',
            (WidgetTester tester) async {
          when(() => tvDetailBloc.state).thenReturn(tTvDetailHasDataState);
          when(() => tvRecomendationBloc.state).thenReturn(
            TvRecomendationEmpty(),
          );

          final contentDetailFinder =
              find.byKey(const Key('content_detail_tv'));
          final contentEmptyFinder = find.byKey(
            const Key('empty_widget_tv'),
          );
          final contentEmptyRecomendationTextFinder =
              find.text('Oops, Recomendation tvseries is empty.');

          await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
            id: 1,
          )));

          expect(contentDetailFinder, findsOneWidget);
          expect(contentEmptyFinder, findsOneWidget);
          expect(contentEmptyRecomendationTextFinder, findsOneWidget);
        });
      });
    });
  });
}
