// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ServiceCategoryController = BindInject(
  (i) => ServiceCategoryController(
      i<GetServiceCategoryUseCase>(),
      i<DeleteServiceCategoryUseCase>(),
      i<SaveServiceCategoryUseCase>(),
      i<EditServiceCategoryUseCase>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceCategoryController on _ServiceCategoryControllerBase, Store {
  final _$listServiceCategoryEntityAtom =
      Atom(name: '_ServiceCategoryControllerBase.listServiceCategoryEntity');

  @override
  List<ServiceCategoryEntity> get listServiceCategoryEntity {
    _$listServiceCategoryEntityAtom.reportRead();
    return super.listServiceCategoryEntity;
  }

  @override
  set listServiceCategoryEntity(List<ServiceCategoryEntity> value) {
    _$listServiceCategoryEntityAtom
        .reportWrite(value, super.listServiceCategoryEntity, () {
      super.listServiceCategoryEntity = value;
    });
  }

  final _$errorAtom = Atom(name: '_ServiceCategoryControllerBase.error');

  @override
  Exception? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Exception? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ServiceCategoryControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
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

  final _$getServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.getServiceCategory');

  @override
  Future<void> getServiceCategory() {
    return _$getServiceCategoryAsyncAction
        .run(() => super.getServiceCategory());
  }

  final _$updateServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.updateServiceCategory');

  @override
  Future<ServiceCategoryEntity> updateServiceCategory(
      ServiceCategoryEntity entity) {
    return _$updateServiceCategoryAsyncAction
        .run(() => super.updateServiceCategory(entity));
  }

  final _$saveServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.saveServiceCategory');

  @override
  Future<ServiceCategoryEntity> saveServiceCategory(
      {required String name, required String picture}) {
    return _$saveServiceCategoryAsyncAction
        .run(() => super.saveServiceCategory(name: name, picture: picture));
  }

  final _$deleteServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.deleteServiceCategory');

  @override
  Future<int> deleteServiceCategory(int id) {
    return _$deleteServiceCategoryAsyncAction
        .run(() => super.deleteServiceCategory(id));
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
  String toString() {
    return '''
listServiceCategoryEntity: ${listServiceCategoryEntity},
error: ${error},
loading: ${loading},
name: ${name},
picture: ${picture}
    ''';
  }
}
