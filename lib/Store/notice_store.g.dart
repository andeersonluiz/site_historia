// GENERATED CODE - DO NOT MODIFY BY HAND

part of NoticeStore;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoticeStore on _NoticeStoreBase, Store {
  final _$listNoticesAtom = Atom(name: '_NoticeStoreBase.listNotices');

  @override
  ObservableFuture<dynamic>? get listNotices {
    _$listNoticesAtom.reportRead();
    return super.listNotices;
  }

  @override
  set listNotices(ObservableFuture<dynamic>? value) {
    _$listNoticesAtom.reportWrite(value, super.listNotices, () {
      super.listNotices = value;
    });
  }

  final _$listNoticesFilteredAtom =
      Atom(name: '_NoticeStoreBase.listNoticesFiltered');

  @override
  ObservableFuture<dynamic>? get listNoticesFiltered {
    _$listNoticesFilteredAtom.reportRead();
    return super.listNoticesFiltered;
  }

  @override
  set listNoticesFiltered(ObservableFuture<dynamic>? value) {
    _$listNoticesFilteredAtom.reportWrite(value, super.listNoticesFiltered, () {
      super.listNoticesFiltered = value;
    });
  }

  final _$listRecentPodcastAtom =
      Atom(name: '_NoticeStoreBase.listRecentPodcast');

  @override
  ObservableFuture<dynamic>? get listRecentPodcast {
    _$listRecentPodcastAtom.reportRead();
    return super.listRecentPodcast;
  }

  @override
  set listRecentPodcast(ObservableFuture<dynamic>? value) {
    _$listRecentPodcastAtom.reportWrite(value, super.listRecentPodcast, () {
      super.listRecentPodcast = value;
    });
  }

  final _$listRecentNoticesAtom =
      Atom(name: '_NoticeStoreBase.listRecentNotices');

  @override
  ObservableFuture<dynamic>? get listRecentNotices {
    _$listRecentNoticesAtom.reportRead();
    return super.listRecentNotices;
  }

  @override
  set listRecentNotices(ObservableFuture<dynamic>? value) {
    _$listRecentNoticesAtom.reportWrite(value, super.listRecentNotices, () {
      super.listRecentNotices = value;
    });
  }

  final _$listSlidersAtom = Atom(name: '_NoticeStoreBase.listSliders');

  @override
  ObservableFuture<dynamic>? get listSliders {
    _$listSlidersAtom.reportRead();
    return super.listSliders;
  }

  @override
  set listSliders(ObservableFuture<dynamic>? value) {
    _$listSlidersAtom.reportWrite(value, super.listSliders, () {
      super.listSliders = value;
    });
  }

  final _$isEditingAtom = Atom(name: '_NoticeStoreBase.isEditing');

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  final _$barSelectedAtom = Atom(name: '_NoticeStoreBase.barSelected');

  @override
  String get barSelected {
    _$barSelectedAtom.reportRead();
    return super.barSelected;
  }

  @override
  set barSelected(String value) {
    _$barSelectedAtom.reportWrite(value, super.barSelected, () {
      super.barSelected = value;
    });
  }

  final _$getNoticesAsyncAction = AsyncAction('_NoticeStoreBase.getNotices');

  @override
  Future getNotices() {
    return _$getNoticesAsyncAction.run(() => super.getNotices());
  }

  final _$getRecentNoticesAsyncAction =
      AsyncAction('_NoticeStoreBase.getRecentNotices');

  @override
  Future getRecentNotices() {
    return _$getRecentNoticesAsyncAction.run(() => super.getRecentNotices());
  }

  final _$getRecentPodcastsAsyncAction =
      AsyncAction('_NoticeStoreBase.getRecentPodcasts');

  @override
  Future getRecentPodcasts() {
    return _$getRecentPodcastsAsyncAction.run(() => super.getRecentPodcasts());
  }

  final _$_NoticeStoreBaseActionController =
      ActionController(name: '_NoticeStoreBase');

  @override
  dynamic getNoticeById(String id) {
    final _$actionInfo = _$_NoticeStoreBaseActionController.startAction(
        name: '_NoticeStoreBase.getNoticeById');
    try {
      return super.getNoticeById(id);
    } finally {
      _$_NoticeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEditing() {
    final _$actionInfo = _$_NoticeStoreBaseActionController.startAction(
        name: '_NoticeStoreBase.changeEditing');
    try {
      return super.changeEditing();
    } finally {
      _$_NoticeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateMenuBar(String newItem) {
    final _$actionInfo = _$_NoticeStoreBaseActionController.startAction(
        name: '_NoticeStoreBase.updateMenuBar');
    try {
      return super.updateMenuBar(newItem);
    } finally {
      _$_NoticeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterListNotices(String value) {
    final _$actionInfo = _$_NoticeStoreBaseActionController.startAction(
        name: '_NoticeStoreBase.filterListNotices');
    try {
      return super.filterListNotices(value);
    } finally {
      _$_NoticeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listNotices: ${listNotices},
listNoticesFiltered: ${listNoticesFiltered},
listRecentPodcast: ${listRecentPodcast},
listRecentNotices: ${listRecentNotices},
listSliders: ${listSliders},
isEditing: ${isEditing},
barSelected: ${barSelected}
    ''';
  }
}
