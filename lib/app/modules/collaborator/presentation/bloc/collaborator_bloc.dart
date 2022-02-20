import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator/delete_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator_service/delete_collaborator_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/edit_collaborator/edit_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/get_collaborator/get_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/save_collaborator/save_collaborator_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollaboratorBloc extends Bloc<CollaboratorEvent, CollaboratorState> {
  final GetCollaboratorUseCase _getCollaboratorUsecase;
  final DeleteCollaboratorUseCase _deleteCollaboratorUseCase;
  final SaveCollaboratorUseCase _saveCollaboratorUseCase;
  final EditCollaboratorUseCase _editCollaboratorUseCase;
  final DeleteCollaboratorServiceUseCase _deleteCollaboratorServiceUseCase;

  CollaboratorBloc(
      this._getCollaboratorUsecase,
      this._deleteCollaboratorUseCase,
      this._saveCollaboratorUseCase,
      this._editCollaboratorUseCase,
      this._deleteCollaboratorServiceUseCase)
      : super(CollaboratorStateIdle()) {
    on<CollaboratorFetchList>(_fetchList);
    on<CollaboratorDelete>(_delete);
    on<CollaboratorUpdate>(_update);
    on<CollaboratorInsert>(_insert);
    on<CollaboratorServiceDelete>(_deleteService);
  }

  void _fetchList(
      CollaboratorFetchList event, Emitter<CollaboratorState> emit) async {
    emit(CollaboratorStateLoading());

    try {
      final result = await _getCollaboratorUsecase();
      result.fold((_error) => emit(CollaboratorStateError(_error)),
          (_success) => emit(CollaboratorStateSuccess(_success)));
    } catch (error) {
      emit(CollaboratorStateError(error));
    }
  }

  void _delete(
      CollaboratorDelete event, Emitter<CollaboratorState> emit) async {
    emit(CollaboratorStateLoading());

    try {
      final result = await _deleteCollaboratorUseCase(event.id);
      result.fold((_error) => emit(CollaboratorStateError(_error)),
          (_success) => emit(CollaboratorStateDeleted(_success)));
    } catch (error) {
      emit(CollaboratorStateError(error));
    }
  }

  void _update(
      CollaboratorUpdate event, Emitter<CollaboratorState> emit) async {
    emit(CollaboratorStateLoading());

    try {
      final result = await _editCollaboratorUseCase(event.entity);
      result.fold((_error) => emit(CollaboratorStateError(_error)),
          (_success) => emit(CollaboratorStateSaved(_success)));
    } catch (error) {
      emit(CollaboratorStateError(error));
    }
  }

  void _insert(
      CollaboratorInsert event, Emitter<CollaboratorState> emit) async {
    emit(CollaboratorStateLoading());

    try {
      final result = await _saveCollaboratorUseCase(event.entity);
      result.fold((_error) => emit(CollaboratorStateError(_error)),
          (_success) => emit(CollaboratorStateSaved(_success)));
    } catch (error) {
      emit(CollaboratorStateError(error));
    }
  }

  void _deleteService(
      CollaboratorServiceDelete event, Emitter<CollaboratorState> emit) async {
    emit(CollaboratorStateLoading());

    try {
      final result = await _deleteCollaboratorServiceUseCase(event.id);
      result.fold((_error) => emit(CollaboratorStateError(_error)),
              (_success) => emit(CollaboratorStateDeleted(_success)));
    } catch (error) {
      emit(CollaboratorStateError(error));
    }
  }
}
