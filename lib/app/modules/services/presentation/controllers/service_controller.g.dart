// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceController on _ServiceControllerBase, Store {
  final _$listServiceEntityAtom =
      Atom(name: '_ServiceControllerBase.listServiceEntity');

  @override
  List<ServiceEntity>? get listServiceEntity {
    _$listServiceEntityAtom.reportRead();
    return super.listServiceEntity;
  }

  @override
  set listServiceEntity(List<ServiceEntity>? value) {
    _$listServiceEntityAtom.reportWrite(value, super.listServiceEntity, () {
      super.listServiceEntity = value;
    });
  }

  final _$nameAtom = Atom(name: '_ServiceControllerBase.name');

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

  final _$categoryAtom = Atom(name: '_ServiceControllerBase.category');

  @override
  int? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(int? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ServiceControllerBase.isLoading');

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

  final _$getServiceAsyncAction =
      AsyncAction('_ServiceControllerBase.getService');

  @override
  Future getService() {
    return _$getServiceAsyncAction.run(() => super.getService());
  }

  final _$_ServiceControllerBaseActionController =
      ActionController(name: '_ServiceControllerBase');

  @override
  void setName(String _name) {
    final _$actionInfo = _$_ServiceControllerBaseActionController.startAction(
        name: '_ServiceControllerBase.setName');
    try {
      return super.setName(_name);
    } finally {
      _$_ServiceControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool _isLoading) {
    final _$actionInfo = _$_ServiceControllerBaseActionController.startAction(
        name: '_ServiceControllerBase.setLoading');
    try {
      return super.setLoading(_isLoading);
    } finally {
      _$_ServiceControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listServiceEntity: ${listServiceEntity},
name: ${name},
category: ${category},
isLoading: ${isLoading}
    ''';
  }
}
