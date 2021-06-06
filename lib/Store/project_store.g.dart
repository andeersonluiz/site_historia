// GENERATED CODE - DO NOT MODIFY BY HAND

part of ProjectStore;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProjectStore on _ProjectStoreBase, Store {
  final _$listProjectsAtom = Atom(name: '_ProjectStoreBase.listProjects');

  @override
  ObservableFuture<dynamic>? get listProjects {
    _$listProjectsAtom.reportRead();
    return super.listProjects;
  }

  @override
  set listProjects(ObservableFuture<dynamic>? value) {
    _$listProjectsAtom.reportWrite(value, super.listProjects, () {
      super.listProjects = value;
    });
  }

  final _$listProjectsOrderedAtom =
      Atom(name: '_ProjectStoreBase.listProjectsOrdered');

  @override
  ObservableList<dynamic> get listProjectsOrdered {
    _$listProjectsOrderedAtom.reportRead();
    return super.listProjectsOrdered;
  }

  @override
  set listProjectsOrdered(ObservableList<dynamic> value) {
    _$listProjectsOrderedAtom.reportWrite(value, super.listProjectsOrdered, () {
      super.listProjectsOrdered = value;
    });
  }

  final _$getProjectsAsyncAction = AsyncAction('_ProjectStoreBase.getProjects');

  @override
  Future getProjects() {
    return _$getProjectsAsyncAction.run(() => super.getProjects());
  }

  final _$addProjectAsyncAction = AsyncAction('_ProjectStoreBase.addProject');

  @override
  Future addProject(String title, PickedFile? imageHeader, String? content,
      List<Teacher> listTeacher, List<String> listParticipant, String author) {
    return _$addProjectAsyncAction.run(() => super.addProject(
        title, imageHeader, content, listTeacher, listParticipant, author));
  }

  final _$updateProjectAsyncAction =
      AsyncAction('_ProjectStoreBase.updateProject');

  @override
  Future updateProject(
      int id,
      String title,
      PickedFile? imageHeader,
      String? content,
      List<Teacher> listTeacher,
      List<String> listParticipant,
      String author) {
    return _$updateProjectAsyncAction.run(() => super.updateProject(
        id, title, imageHeader, content, listTeacher, listParticipant, author));
  }

  final _$_ProjectStoreBaseActionController =
      ActionController(name: '_ProjectStoreBase');

  @override
  dynamic getProjectById(String id) {
    final _$actionInfo = _$_ProjectStoreBaseActionController.startAction(
        name: '_ProjectStoreBase.getProjectById');
    try {
      return super.getProjectById(id);
    } finally {
      _$_ProjectStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listProjects: ${listProjects},
listProjectsOrdered: ${listProjectsOrdered}
    ''';
  }
}
