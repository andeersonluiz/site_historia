// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportStore on _SupportStoreBase, Store {
  Computed<bool>? _$openProjectComputed;

  @override
  bool get openProject =>
      (_$openProjectComputed ??= Computed<bool>(() => super.openProject,
              name: '_SupportStoreBase.openProject'))
          .value;
  Computed<bool>? _$openQuadsComputed;

  @override
  bool get openQuads =>
      (_$openQuadsComputed ??= Computed<bool>(() => super.openQuads,
              name: '_SupportStoreBase.openQuads'))
          .value;

  final _$_openProjectAtom = Atom(name: '_SupportStoreBase._openProject');

  @override
  bool get _openProject {
    _$_openProjectAtom.reportRead();
    return super._openProject;
  }

  @override
  set _openProject(bool value) {
    _$_openProjectAtom.reportWrite(value, super._openProject, () {
      super._openProject = value;
    });
  }

  final _$_openQuadsAtom = Atom(name: '_SupportStoreBase._openQuads');

  @override
  bool get _openQuads {
    _$_openQuadsAtom.reportRead();
    return super._openQuads;
  }

  @override
  set _openQuads(bool value) {
    _$_openQuadsAtom.reportWrite(value, super._openQuads, () {
      super._openQuads = value;
    });
  }

  final _$_SupportStoreBaseActionController =
      ActionController(name: '_SupportStoreBase');

  @override
  dynamic updateOpen(String item) {
    final _$actionInfo = _$_SupportStoreBaseActionController.startAction(
        name: '_SupportStoreBase.updateOpen');
    try {
      return super.updateOpen(item);
    } finally {
      _$_SupportStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
openProject: ${openProject},
openQuads: ${openQuads}
    ''';
  }
}
