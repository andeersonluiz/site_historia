// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TeacherStore on _TeacherStoreBase, Store {
  final _$listTeachersAtom = Atom(name: '_TeacherStoreBase.listTeachers');

  @override
  ObservableFuture<dynamic>? get listTeachers {
    _$listTeachersAtom.reportRead();
    return super.listTeachers;
  }

  @override
  set listTeachers(ObservableFuture<dynamic>? value) {
    _$listTeachersAtom.reportWrite(value, super.listTeachers, () {
      super.listTeachers = value;
    });
  }

  final _$getTeachersAsyncAction = AsyncAction('_TeacherStoreBase.getTeachers');

  @override
  Future getTeachers() {
    return _$getTeachersAsyncAction.run(() => super.getTeachers());
  }

  @override
  String toString() {
    return '''
listTeachers: ${listTeachers}
    ''';
  }
}
