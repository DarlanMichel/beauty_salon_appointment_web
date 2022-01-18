import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CollaboratorEvent extends Equatable {
  const CollaboratorEvent();
  @override
  List<Object> get props => [];
}

class CollaboratorFetchList extends CollaboratorEvent {
  const CollaboratorFetchList();
  @override
  List<Object> get props => [];
}

class CollaboratorDelete extends CollaboratorEvent {
  final int id;
  const CollaboratorDelete(this.id);
  @override
  List<Object> get props => [id];
}

class CollaboratorUpdate extends CollaboratorEvent {
  final CollaboratorEntity entity;
  const CollaboratorUpdate(this.entity);
  @override
  List<Object> get props => [entity];
}

class CollaboratorInsert extends CollaboratorEvent {
  final CollaboratorEntity entity;
  const CollaboratorInsert(this.entity);
  @override
  List<Object> get props => [entity];
}