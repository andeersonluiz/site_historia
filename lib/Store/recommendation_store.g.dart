// GENERATED CODE - DO NOT MODIFY BY HAND

part of RecommendationStore;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecommendationStore on _RecommendationStoreBase, Store {
  final _$recommendationAtom =
      Atom(name: '_RecommendationStoreBase.recommendation');

  @override
  Recommendation? get recommendation {
    _$recommendationAtom.reportRead();
    return super.recommendation;
  }

  @override
  set recommendation(Recommendation? value) {
    _$recommendationAtom.reportWrite(value, super.recommendation, () {
      super.recommendation = value;
    });
  }

  final _$saveRecommendationAsyncAction =
      AsyncAction('_RecommendationStoreBase.saveRecommendation');

  @override
  Future saveRecommendation(Recommendation recommendation) {
    return _$saveRecommendationAsyncAction
        .run(() => super.saveRecommendation(recommendation));
  }

  final _$_RecommendationStoreBaseActionController =
      ActionController(name: '_RecommendationStoreBase');

  @override
  dynamic addYoutube() {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.addYoutube');
    try {
      return super.addYoutube();
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationYoutubeName(int id, String name) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationYoutubeName');
    try {
      return super.updateRecommendationYoutubeName(id, name);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationYoutubeUrl(int id, String url) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationYoutubeUrl');
    try {
      return super.updateRecommendationYoutubeUrl(id, url);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeYoutube(RecommendationItem recommendationItem) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.removeYoutube');
    try {
      return super.removeYoutube(recommendationItem);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVideo() {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.addVideo');
    try {
      return super.addVideo();
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationVideoName(int id, String name) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationVideoName');
    try {
      return super.updateRecommendationVideoName(id, name);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationVideoUrl(int id, String url) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationVideoUrl');
    try {
      return super.updateRecommendationVideoUrl(id, url);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeVideo(RecommendationItem recommendationItem) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.removeVideo');
    try {
      return super.removeVideo(recommendationItem);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPodcast() {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.addPodcast');
    try {
      return super.addPodcast();
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationPodcastName(int id, String name) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationPodcastName');
    try {
      return super.updateRecommendationPodcastName(id, name);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationPodcastUrl(int id, String url) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationPodcastUrl');
    try {
      return super.updateRecommendationPodcastUrl(id, url);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removePodcast(RecommendationItem recommendationItem) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.removePodcast');
    try {
      return super.removePodcast(recommendationItem);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addOther() {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.addOther');
    try {
      return super.addOther();
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationOtherName(int id, String name) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationOtherName');
    try {
      return super.updateRecommendationOtherName(id, name);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecommendationOtherUrl(int id, String url) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.updateRecommendationOtherUrl');
    try {
      return super.updateRecommendationOtherUrl(id, url);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeOther(RecommendationItem recommendationItem) {
    final _$actionInfo = _$_RecommendationStoreBaseActionController.startAction(
        name: '_RecommendationStoreBase.removeOther');
    try {
      return super.removeOther(recommendationItem);
    } finally {
      _$_RecommendationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
recommendation: ${recommendation}
    ''';
  }
}
