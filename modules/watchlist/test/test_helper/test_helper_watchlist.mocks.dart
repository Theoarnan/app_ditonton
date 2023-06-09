// Mocks generated by Mockito 5.4.1 from annotations
// in watchlist/test/test_helper/test_helper_watchlist.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/core.dart' as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/movies.dart' as _i7;
import 'package:sqflite/sqflite.dart' as _i5;
import 'package:tvseries/tvseries.dart' as _i8;
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart'
    as _i9;
import 'package:watchlist/data/models/watchlist_table_model.dart' as _i10;
import 'package:watchlist/domain/repositories/watchlist_repository.dart' as _i6;
import 'package:watchlist/domain/usecases/get_watchlist_movies.dart' as _i11;
import 'package:watchlist/domain/usecases/get_watchlist_tv.dart' as _i12;

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

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i3.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i5.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i5.Database?>.value(),
      ) as _i4.Future<_i5.Database?>);
  @override
  set database(_i4.Future<_i5.Database?>? name) => super.noSuchMethod(
        Invocation.setter(
          #database,
          name,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<int> insertWatchlist(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [data],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<int> removeWatchlist(dynamic data) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [data],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<Map<String, dynamic>?> getWatchlistById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistById,
          [id],
        ),
        returnValue: _i4.Future<Map<String, dynamic>?>.value(),
      ) as _i4.Future<Map<String, dynamic>?>);
  @override
  _i4.Future<List<Map<String, dynamic>>> getWatchlist(
          {required String? typeWatchlist}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
          {#typeWatchlist: typeWatchlist},
        ),
        returnValue: _i4.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i4.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [WatchlistRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistRepository extends _i1.Mock
    implements _i6.WatchlistRepository {
  MockWatchlistRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i3.Failure, String>> saveWatchlistMovie(
          _i7.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistMovie,
          [movie],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistMovie,
            [movie],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, String>> saveWatchlistTv(
          _i8.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistTv,
          [tv],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistTv,
            [tv],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, String>> removeWatchlistMovie(
          _i7.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistMovie,
            [movie],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, String>> removeWatchlistTv(
          _i8.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTv,
          [tv],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, String>>.value(
            _FakeEither_0<_i3.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistTv,
            [tv],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, String>>);
  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlist,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>> getWatchlistMovie() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovie,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #getWatchlistMovie,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>>.value(
            _FakeEither_0<_i3.Failure, List<_i8.Tv>>(
          this,
          Invocation.method(
            #getWatchlistTv,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>>);
}

/// A class which mocks [WatchlistLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistLocalDataSource extends _i1.Mock
    implements _i9.WatchlistLocalDataSource {
  MockWatchlistLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<String> insertWatchlist(_i10.WatchlistTableModel? watchlist) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [watchlist],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<String> removeWatchlist(_i10.WatchlistTableModel? watchlist) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [watchlist],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<_i10.WatchlistTableModel?> getWatchlistById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistById,
          [id],
        ),
        returnValue: _i4.Future<_i10.WatchlistTableModel?>.value(),
      ) as _i4.Future<_i10.WatchlistTableModel?>);
  @override
  _i4.Future<List<_i10.WatchlistTableModel>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i4.Future<List<_i10.WatchlistTableModel>>.value(
            <_i10.WatchlistTableModel>[]),
      ) as _i4.Future<List<_i10.WatchlistTableModel>>);
  @override
  _i4.Future<List<_i10.WatchlistTableModel>> getWatchlistTv() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTv,
          [],
        ),
        returnValue: _i4.Future<List<_i10.WatchlistTableModel>>.value(
            <_i10.WatchlistTableModel>[]),
      ) as _i4.Future<List<_i10.WatchlistTableModel>>);
}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i11.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>>.value(
            _FakeEither_0<_i3.Failure, List<_i7.Movie>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, List<_i7.Movie>>>);
}

/// A class which mocks [GetWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTv extends _i1.Mock implements _i12.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>>.value(
            _FakeEither_0<_i3.Failure, List<_i8.Tv>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, List<_i8.Tv>>>);
}
