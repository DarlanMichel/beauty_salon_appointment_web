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

  final _$getServiceCategoryAsyncAction =
      AsyncAction('_ServiceCategoryControllerBase.getServiceCategory');

  @override
  Future getServiceCategory() {
    return _$getServiceCategoryAsyncAction
        .run(() => super.getServiceCategory());
  }

  @override
  String toString() {
    return '''
listServiceCategoryEntity: ${listServiceCategoryEntity}
    ''';
  }
}
