// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuotesListStore on _QuotesListStore, Store {
  final _$allQuotesAtom = Atom(name: '_QuotesListStore.allQuotes');

  @override
  ObservableList<dynamic> get allQuotes {
    _$allQuotesAtom.reportRead();
    return super.allQuotes;
  }

  @override
  set allQuotes(ObservableList<dynamic> value) {
    _$allQuotesAtom.reportWrite(value, super.allQuotes, () {
      super.allQuotes = value;
    });
  }

  final _$initHiveDBAtom = Atom(name: '_QuotesListStore.initHiveDB');

  @override
  bool get initHiveDB {
    _$initHiveDBAtom.reportRead();
    return super.initHiveDB;
  }

  @override
  set initHiveDB(bool value) {
    _$initHiveDBAtom.reportWrite(value, super.initHiveDB, () {
      super.initHiveDB = value;
    });
  }

  final _$getQuotesAsyncAction = AsyncAction('_QuotesListStore.getQuotes');

  @override
  Future<void> getQuotes() {
    return _$getQuotesAsyncAction.run(() => super.getQuotes());
  }

  @override
  String toString() {
    return '''
allQuotes: ${allQuotes},
initHiveDB: ${initHiveDB}
    ''';
  }
}
