// Mocks generated by Mockito 5.4.0 from annotations
// in app_ditonton/test/features/tvseries/presentation/pages/home_tv_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i9;

import 'package:app_ditonton/common/state_enum.dart' as _i6;
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart' as _i7;
import 'package:app_ditonton/features/tvseries/domain/usecases/get_on_the_air_tv.dart'
    as _i2;
import 'package:app_ditonton/features/tvseries/domain/usecases/get_popular_tv.dart'
    as _i3;
import 'package:app_ditonton/features/tvseries/domain/usecases/get_top_rated_tv.dart'
    as _i4;
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetOnTheAirTv_0 extends _i1.SmartFake implements _i2.GetOnTheAirTv {
  _FakeGetOnTheAirTv_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularTv_1 extends _i1.SmartFake implements _i3.GetPopularTv {
  _FakeGetPopularTv_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTopRatedTv_2 extends _i1.SmartFake implements _i4.GetTopRatedTv {
  _FakeGetTopRatedTv_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvListNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvListNotifier extends _i1.Mock implements _i5.TvListNotifier {
  MockTvListNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetOnTheAirTv get getOnTheAirTv => (super.noSuchMethod(
        Invocation.getter(#getOnTheAirTv),
        returnValue: _FakeGetOnTheAirTv_0(
          this,
          Invocation.getter(#getOnTheAirTv),
        ),
      ) as _i2.GetOnTheAirTv);
  @override
  _i3.GetPopularTv get getPopularTv => (super.noSuchMethod(
        Invocation.getter(#getPopularTv),
        returnValue: _FakeGetPopularTv_1(
          this,
          Invocation.getter(#getPopularTv),
        ),
      ) as _i3.GetPopularTv);
  @override
  _i4.GetTopRatedTv get getTopRatedTv => (super.noSuchMethod(
        Invocation.getter(#getTopRatedTv),
        returnValue: _FakeGetTopRatedTv_2(
          this,
          Invocation.getter(#getTopRatedTv),
        ),
      ) as _i4.GetTopRatedTv);
  @override
  _i6.RequestState get onTheAirState => (super.noSuchMethod(
        Invocation.getter(#onTheAirState),
        returnValue: _i6.RequestState.empty,
      ) as _i6.RequestState);
  @override
  List<_i7.Tv> get onTheAirTv => (super.noSuchMethod(
        Invocation.getter(#onTheAirTv),
        returnValue: <_i7.Tv>[],
      ) as List<_i7.Tv>);
  @override
  List<_i7.Tv> get popularTv => (super.noSuchMethod(
        Invocation.getter(#popularTv),
        returnValue: <_i7.Tv>[],
      ) as List<_i7.Tv>);
  @override
  _i6.RequestState get popularTvState => (super.noSuchMethod(
        Invocation.getter(#popularTvState),
        returnValue: _i6.RequestState.empty,
      ) as _i6.RequestState);
  @override
  List<_i7.Tv> get topRatedTv => (super.noSuchMethod(
        Invocation.getter(#topRatedTv),
        returnValue: <_i7.Tv>[],
      ) as List<_i7.Tv>);
  @override
  _i6.RequestState get topRatedTvState => (super.noSuchMethod(
        Invocation.getter(#topRatedTvState),
        returnValue: _i6.RequestState.empty,
      ) as _i6.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i8.Future<void> fetchOnTheAirTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchOnTheAirTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchPopularTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchPopularTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  _i8.Future<void> fetchTopRatedTv() => (super.noSuchMethod(
        Invocation.method(
          #fetchTopRatedTv,
          [],
        ),
        returnValue: _i8.Future<void>.value(),
        returnValueForMissingStub: _i8.Future<void>.value(),
      ) as _i8.Future<void>);
  @override
  void addListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i9.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}