// Mocks generated by Mockito 5.4.0 from annotations
// in app_ditonton/test/features/watchlist/presentation/provider/watchlist_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:app_ditonton/common/failure.dart' as _i5;
import 'package:app_ditonton/domain/entities/movie.dart' as _i6;
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart' as _i8;
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_movies.dart'
    as _i3;
import 'package:app_ditonton/features/watchlist/domain/usecases/get_watchlist_tv.dart'
    as _i7;
import 'package:dartz/dartz.dart' as _i2;
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i3.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
}

/// A class which mocks [GetWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTv extends _i1.Mock implements _i7.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.Tv>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i8.Tv>>>.value(
            _FakeEither_0<_i5.Failure, List<_i8.Tv>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.Tv>>>);
}