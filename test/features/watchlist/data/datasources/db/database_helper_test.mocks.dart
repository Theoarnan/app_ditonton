// Mocks generated by Mockito 5.4.0 from annotations
// in app_ditonton/test/features/watchlist/data/datasources/db/database_helper_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:app_ditonton/features/watchlist/data/datasources/db/database_helper.dart'
    as _i2;
import 'package:app_ditonton/features/watchlist/data/models/watchlist_table_model.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i4;

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

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i2.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i3.Future<_i4.Database?>.value(),
      ) as _i3.Future<_i4.Database?>);
  @override
  set database(_i3.Future<_i4.Database?>? name) => super.noSuchMethod(
        Invocation.setter(
          #database,
          name,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<int> insertWatchlist(_i5.WatchlistTableModel? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlist,
          [data],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<int> removeWatchlist(_i5.WatchlistTableModel? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlist,
          [data],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<Map<String, dynamic>?> getWatchlistById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistById,
          [id],
        ),
        returnValue: _i3.Future<Map<String, dynamic>?>.value(),
      ) as _i3.Future<Map<String, dynamic>?>);
  @override
  _i3.Future<List<Map<String, dynamic>>> getWatchlist(
          {required String? typeWatchlist}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
          {#typeWatchlist: typeWatchlist},
        ),
        returnValue: _i3.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i3.Future<List<Map<String, dynamic>>>);
}