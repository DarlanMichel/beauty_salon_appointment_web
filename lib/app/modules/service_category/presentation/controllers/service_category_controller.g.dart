// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceCategoryController on _ServiceCategoryControllerBase, Store {
  final _$listServiceCategoryEntityAtom =
      Atom(name: '_ServiceCategoryControllerBase.listServiceCategoryEntity');

  @override
  List<ServiceCategoryEntity>? get listServiceCategoryEntity {
    _$listServiceCategoryEntityAtom.reportRead();
    return super.listServiceCategoryEntity;
  }

  @override
  set listServiceCategoryEntity(List<ServiceCategoryEntity>? value) {
    _$listServiceCategoryEntityAtom
        .reportWrite(value, super.listServiceCategoryEntity, () {
      super.listServiceCategoryEntity = value;
    });
  }

  final _$nameAtom = Atom(name: '_ServiceCategoryControllerBase.name');

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$pictureAtom = Atom(name: '_ServiceCategoryControllerBase.picture');

  @override
  String? get picture {
    _$pictureAtom.reportRead();
    return super.picture;
  }

  @override
  set picture(String? value) {
    _$pictureAtom.reportWrite(value, super.picture, () {
      super.picture = value;
    });
  }

  final _$isLoadingAtom =
      Atom(name: '_ServiceCategoryControllerBase.isLoading');

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

  final _$getServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.getServiceCategory');

  @override
  Future getServiceCategory() {
    return _$getServiceCategoryAsyncAction
        .run(() => super.getServiceCategory());
  }

  final _$_ServiceCategoryControllerBaseActionController =
      ActionController(name: '_ServiceCategoryControllerBase');

  @override
  void setName(String _name) {
    final _$actionInfo = _$_ServiceCategoryControllerBaseActionController
        .startAction(name: '_ServiceCategoryControllerBase.setName');
    try {
      return super.setName(_name);
    } finally {
      _$_ServiceCategoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPicture(String? _picture) {
    final _$actionInfo = _$_ServiceCategoryControllerBaseActionController
        .startAction(name: '_ServiceCategoryControllerBase.setPicture');
    try {
      return super.setPicture(_picture);
    } finally {
      _$_ServiceCategoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool _isLoading) {
    final _$actionInfo = _$_ServiceCategoryControllerBaseActionController
        .startAction(name: '_ServiceCategoryControllerBase.setLoading');
    try {
      return super.setLoading(_isLoading);
    } finally {
      _$_ServiceCategoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listServiceCategoryEntity: ${listServiceCategoryEntity},
name: ${name},
picture: ${picture},
isLoading: ${isLoading}
    ''';
  }
}
