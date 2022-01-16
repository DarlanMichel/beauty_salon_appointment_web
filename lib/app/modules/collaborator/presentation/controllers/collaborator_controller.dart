import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator/delete_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/edit_collaborator/edit_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/get_collaborator/get_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/save_collaborator/save_collaborator_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'collaborator_controller.g.dart';

@Injectable()
class CollaboratorController = _CollaboratorControllerBase
    with _$CollaboratorController;

abstract class _CollaboratorControllerBase with Store {
  final GetCollaboratorUseCase _getCollaboratorUsecase;
  final DeleteCollaboratorUseCase _deleteCollaboratorUseCase;
  final SaveCollaboratorUseCase _saveCollaboratorUseCase;
  final EditCollaboratorUseCase _editCollaboratorUseCase;

  _CollaboratorControllerBase(
      this._getCollaboratorUsecase,
      this._deleteCollaboratorUseCase,
      this._saveCollaboratorUseCase,
      this._editCollaboratorUseCase);

  @observable
  List<CollaboratorEntity> listCollaboratorEntity = [];

  @observable
  Exception? error;

  @observable
  bool loading = false;

  @action
  Future<void> getCollaborator() async {
    loading = true;
    try {
      final result = await _getCollaboratorUsecase();
      result.fold((_error) => error = _error,
          (_success) => listCollaboratorEntity = _success);
    } catch (e) {
      error = Exception('Erro ao pegar colaboradores');
    } finally {
      loading = false;
    }
  }

  @action
  Future<CollaboratorEntity> updateCollaborator(
      CollaboratorEntity entity) async {
    loading = true;
    try {
      var result = await _editCollaboratorUseCase(entity);
      return result.fold(
          (error) => throw ('error in update'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<CollaboratorEntity> saveCollaborator(
      CollaboratorEntity collaboratorEntity) async {
    loading = true;
    try {
      var result = await _saveCollaboratorUseCase(collaboratorEntity);
      return result.fold(
          (error) => throw ('error in insert'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<int> deleteCollaborator(int id) async {
    loading = true;
    try {
      var result = await _deleteCollaboratorUseCase(id);
      return result.fold(
          (error) => throw ('error in delete'), (success) => success);
    } finally {
      loading = false;
    }
  }
}
