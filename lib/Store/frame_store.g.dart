// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FrameStore on _FrameStoreBase, Store {
  final _$listFramesAtom = Atom(name: '_FrameStoreBase.listFrames');

  @override
  ObservableFuture<dynamic>? get listFrames {
    _$listFramesAtom.reportRead();
    return super.listFrames;
  }

  @override
  set listFrames(ObservableFuture<dynamic>? value) {
    _$listFramesAtom.reportWrite(value, super.listFrames, () {
      super.listFrames = value;
    });
  }

  final _$listFramesOrderedAtom =
      Atom(name: '_FrameStoreBase.listFramesOrdered');

  @override
  ObservableList<dynamic> get listFramesOrdered {
    _$listFramesOrderedAtom.reportRead();
    return super.listFramesOrdered;
  }

  @override
  set listFramesOrdered(ObservableList<dynamic> value) {
    _$listFramesOrderedAtom.reportWrite(value, super.listFramesOrdered, () {
      super.listFramesOrdered = value;
    });
  }

  final _$getFramesAsyncAction = AsyncAction('_FrameStoreBase.getFrames');

  @override
  Future getFrames() {
    return _$getFramesAsyncAction.run(() => super.getFrames());
  }

  final _$addFrameAsyncAction = AsyncAction('_FrameStoreBase.addFrame');

  @override
  Future addFrame(
      String title,
      String subtitle,
      PickedFile? imageHeader,
      String subtitleImage,
      String? content,
      PlatformFile audio,
      dynamic video,
      String author) {
    return _$addFrameAsyncAction.run(() => super.addFrame(title, subtitle,
        imageHeader, subtitleImage, content, audio, video, author));
  }

  final _$updateFrameAsyncAction = AsyncAction('_FrameStoreBase.updateFrame');

  @override
  Future updateFrame(
      Frame frame,
      String title,
      String subtitle,
      PickedFile? imageHeader,
      String subtitleImage,
      String? content,
      PlatformFile audio,
      dynamic video,
      int views,
      String author) {
    return _$updateFrameAsyncAction.run(() => super.updateFrame(
        frame,
        title,
        subtitle,
        imageHeader,
        subtitleImage,
        content,
        audio,
        video,
        views,
        author));
  }

  final _$deleteFrameAsyncAction = AsyncAction('_FrameStoreBase.deleteFrame');

  @override
  Future deleteFrame(int id) {
    return _$deleteFrameAsyncAction.run(() => super.deleteFrame(id));
  }

  final _$getFramesSortedByTitleAsyncAction =
      AsyncAction('_FrameStoreBase.getFramesSortedByTitle');

  @override
  Future getFramesSortedByTitle() {
    return _$getFramesSortedByTitleAsyncAction
        .run(() => super.getFramesSortedByTitle());
  }

  final _$_FrameStoreBaseActionController =
      ActionController(name: '_FrameStoreBase');

  @override
  dynamic getFrameById(String id) {
    final _$actionInfo = _$_FrameStoreBaseActionController.startAction(
        name: '_FrameStoreBase.getFrameById');
    try {
      return super.getFrameById(id);
    } finally {
      _$_FrameStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listFrames: ${listFrames},
listFramesOrdered: ${listFramesOrdered}
    ''';
  }
}
