// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_store.dart';

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

  final _$isEdittingAtom = Atom(name: '_NoticeStoreBase.isEditting');

  @override
  bool get isEditting {
    _$isEdittingAtom.reportRead();
    return super.isEditting;
  }

  @override
  set isEditting(bool value) {
    _$isEdittingAtom.reportWrite(value, super.isEditting, () {
      super.isEditting = value;
    });
  }

  final _$getNoticesAsyncAction = AsyncAction('_NoticeStoreBase.getNotices');

  @override
  Future getNotices() {
    return _$getNoticesAsyncAction.run(() => super.getNotices());
  }

  final _$getNoticeByIdAsyncAction =
      AsyncAction('_NoticeStoreBase.getNoticeById');

  @override
  Future getNoticeById(String id) {
    return _$getNoticeByIdAsyncAction.run(() => super.getNoticeById(id));
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
  dynamic changeEddting() {
    final _$actionInfo = _$_NoticeStoreBaseActionController.startAction(
        name: '_NoticeStoreBase.changeEddting');
    try {
      return super.changeEddting();
    } finally {
      _$_NoticeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listNotices: ${listNotices},
listRecentPodcast: ${listRecentPodcast},
listRecentNotices: ${listRecentNotices},
listSliders: ${listSliders},
isEditting: ${isEditting}
    ''';
  }
}
