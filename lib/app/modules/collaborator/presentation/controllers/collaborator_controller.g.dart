// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaborator_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CollaboratorController = BindInject(
  (i) => CollaboratorController(
      i<GetCollaboratorUseCase>(),
      i<DeleteCollaboratorUseCase>(),
      i<SaveCollaboratorUseCase>(),
      i<EditCollaboratorUseCase>()),
  isSingleton: true,
  isLazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CollaboratorController on _CollaboratorControllerBase, Store {
  final _$listCollaboratorEntityAtom =
      Atom(name: '_CollaboratorControllerBase.listCollaboratorEntity');

  @override
  List<CollaboratorEntity> get listCollaboratorEntity {
    _$listCollaboratorEntityAtom.reportRead();
    return super.listCollaboratorEntity;
  }

  @override
  set listCollaboratorEntity(List<CollaboratorEntity> value) {
    _$listCollaboratorEntityAtom
        .reportWrite(value, super.listCollaboratorEntity, () {
      super.listCollaboratorEntity = value;
    });
  }

  final _$errorAtom = Atom(name: '_CollaboratorControllerBase.error');

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

  final _$loadingAtom = Atom(name: '_CollaboratorControllerBase.loading');

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

  final _$getCollaboratorAsyncAction =
      AsyncAction('_CollaboratorControllerBase.getCollaborator');

  @override
  Future<void> getCollaborator() {
    return _$getCollaboratorAsyncAction.run(() => super.getCollaborator());
  }

  final _$updateCollaboratorAsyncAction =
      AsyncAction('_CollaboratorControllerBase.updateCollaborator');

  @override
  Future<CollaboratorEntity> updateCollaborator(CollaboratorEntity entity) {
    return _$updateCollaboratorAsyncAction
        .run(() => super.updateCollaborator(entity));
  }

  final _$saveCollaboratorAsyncAction =
      AsyncAction('_CollaboratorControllerBase.saveCollaborator');

  @override
  Future<CollaboratorEntity> saveCollaborator(
      CollaboratorEntity collaboratorEntity) {
    return _$saveCollaboratorAsyncAction
        .run(() => super.saveCollaborator(collaboratorEntity));
  }

  final _$deleteCollaboratorAsyncAction =
      AsyncAction('_CollaboratorControllerBase.deleteCollaborator');

  @override
  Future<int> deleteCollaborator(int id) {
    return _$deleteCollaboratorAsyncAction
        .run(() => super.deleteCollaborator(id));
  }

  @override
  String toString() {
    return '''
listCollaboratorEntity: ${listCollaboratorEntity},
error: ${error},
loading: ${loading}
    ''';
  }
}
