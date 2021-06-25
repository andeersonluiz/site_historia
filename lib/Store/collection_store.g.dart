// GENERATED CODE - DO NOT MODIFY BY HAND

part of CollectionStore;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CollectionStore on _CollectionStoreBase, Store {
  final _$collectionAtom = Atom(name: '_CollectionStoreBase.collection');

  @override
  Collection? get collection {
    _$collectionAtom.reportRead();
    return super.collection;
  }

  @override
  set collection(Collection? value) {
    _$collectionAtom.reportWrite(value, super.collection, () {
      super.collection = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_CollectionStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$updateRecommendationExamUrlAsyncAction =
      AsyncAction('_CollectionStoreBase.updateRecommendationExamUrl');

  @override
  Future updateRecommendationExamUrl(int id, String url) {
    return _$updateRecommendationExamUrlAsyncAction
        .run(() => super.updateRecommendationExamUrl(id, url));
  }

  final _$updateRecommendationArticleUrlAsyncAction =
      AsyncAction('_CollectionStoreBase.updateRecommendationArticleUrl');

  @override
  Future updateRecommendationArticleUrl(int id, PlatformFile file) {
    return _$updateRecommendationArticleUrlAsyncAction
        .run(() => super.updateRecommendationArticleUrl(id, file));
  }

  final _$updateRecommendationBookUrlAsyncAction =
      AsyncAction('_CollectionStoreBase.updateRecommendationBookUrl');

  @override
  Future updateRecommendationBookUrl(int id, PlatformFile file) {
    return _$updateRecommendationBookUrlAsyncAction
        .run(() => super.updateRecommendationBookUrl(id, file));
  }

  final _$updateRecommendationOtherUrlAsyncAction =
      AsyncAction('_CollectionStoreBase.updateRecommendationOtherUrl');

  @override
  Future updateRecommendationOtherUrl(int id, PlatformFile file) {
    return _$updateRecommendationOtherUrlAsyncAction
        .run(() => super.updateRecommendationOtherUrl(id, file));
  }

  final _$saveCollectionAsyncAction =
      AsyncAction('_CollectionStoreBase.saveCollection');

  @override
  Future saveCollection(Collection collection) {
    return _$saveCollectionAsyncAction
        .run(() => super.saveCollection(collection));
  }

  final _$_CollectionStoreBaseActionController =
      ActionController(name: '_CollectionStoreBase');

  @override
  dynamic addExam() {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.addExam');
    try {
      return super.addExam();
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationExamName(int id, String name) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.updateRecommendationExamName');
    try {
      return super.updateRecommendationExamName(id, name);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeExam(CollectionItem collectionItem, int id) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.removeExam');
    try {
      return super.removeExam(collectionItem, id);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addArticle() {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.addArticle');
    try {
      return super.addArticle();
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationArticleName(int id, String name) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.updateRecommendationArticleName');
    try {
      return super.updateRecommendationArticleName(id, name);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeArticle(CollectionItem collectionItem, int id) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.removeArticle');
    try {
      return super.removeArticle(collectionItem, id);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addBook() {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.addBook');
    try {
      return super.addBook();
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationBookName(int id, String name) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.updateRecommendationBookName');
    try {
      return super.updateRecommendationBookName(id, name);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeBook(CollectionItem collectionItem, int id) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.removeBook');
    try {
      return super.removeBook(collectionItem, id);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOther() {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.addOther');
    try {
      return super.addOther();
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationOtherName(int id, String name) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.updateRecommendationOtherName');
    try {
      return super.updateRecommendationOtherName(id, name);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeOther(CollectionItem collectionItem, int id) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.removeOther');
    try {
      return super.removeOther(collectionItem, id);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingArticle(int index, bool value) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.setLoadingArticle');
    try {
      return super.setLoadingArticle(index, value);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingBook(int index, bool value) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.setLoadingBook');
    try {
      return super.setLoadingBook(index, value);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingOther(int index, bool value) {
    final _$actionInfo = _$_CollectionStoreBaseActionController.startAction(
        name: '_CollectionStoreBase.setLoadingOther');
    try {
      return super.setLoadingOther(index, value);
    } finally {
      _$_CollectionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
collection: ${collection},
isLoading: ${isLoading}
    ''';
  }
}
