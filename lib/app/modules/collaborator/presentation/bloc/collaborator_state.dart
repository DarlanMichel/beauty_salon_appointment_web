import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:equatable/equatable.dart';

class CollaboratorState extends Equatable {
  const CollaboratorState();
  @override
  List<Object?> get props => [];
}

class CollaboratorStateIdle extends CollaboratorState {}

class CollaboratorStateLoading extends CollaboratorState {}

class CollaboratorStateSuccess extends CollaboratorState {
  final List<CollaboratorEntity> listCollaboratorEntity;

  const CollaboratorStateSuccess(this.listCollaboratorEntity);

  @override
  List<Object?> get props => [listCollaboratorEntity];
}

class CollaboratorStateSaved extends CollaboratorState {
  final CollaboratorEntity entity;

  const CollaboratorStateSaved(this.entity);

  @override
  List<Object?> get props => [entity];
}

class CollaboratorStateDeleted extends CollaboratorState {
  final int index;

  const CollaboratorStateDeleted(this.index);

  @override
  List<Object?> get props => [index];
}

class CollaboratorStateError extends CollaboratorState {
  final dynamic error;

  const CollaboratorStateError(this.error);

  @override
  List<Object> get props => [error];
}