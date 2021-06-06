// GENERATED CODE - DO NOT MODIFY BY HAND

part of TeacherStore;

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

  final _$addTeacherAsyncAction = AsyncAction('_TeacherStoreBase.addTeacher');

  @override
  Future addTeacher(
      String name, PickedFile image, List<Project> projects, String link) {
    return _$addTeacherAsyncAction
        .run(() => super.addTeacher(name, image, projects, link));
  }

  final _$updateTeacherAsyncAction =
      AsyncAction('_TeacherStoreBase.updateTeacher');

  @override
  Future updateTeacher(Teacher teacher, String name, PickedFile image,
      List<Project> projects, String link) {
    return _$updateTeacherAsyncAction
        .run(() => super.updateTeacher(teacher, name, image, projects, link));
  }

  final _$deleteTeacherAsyncAction =
      AsyncAction('_TeacherStoreBase.deleteTeacher');

  @override
  Future deleteTeacher(int id) {
    return _$deleteTeacherAsyncAction.run(() => super.deleteTeacher(id));
  }

  final _$_TeacherStoreBaseActionController =
      ActionController(name: '_TeacherStoreBase');

  @override
  dynamic getTeacherById(String id) {
    final _$actionInfo = _$_TeacherStoreBaseActionController.startAction(
        name: '_TeacherStoreBase.getTeacherById');
    try {
      return super.getTeacherById(id);
    } finally {
      _$_TeacherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listTeachers: ${listTeachers}
    ''';
  }
}
