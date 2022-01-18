import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:equatable/equatable.dart';

class ServiceState extends Equatable {
  const ServiceState();
  @override
  List<Object?> get props => [];
}

class ServiceStateIdle extends ServiceState {}

class ServiceStateLoading extends ServiceState {}

class ServiceStateSuccess extends ServiceState {
  final List<ServiceEntity> listServiceEntity;

  const ServiceStateSuccess(this.listServiceEntity);

  @override
  List<Object?> get props => [listServiceEntity];
}

class ServiceStateSaved extends ServiceState {
  final ServiceEntity entity;

  const ServiceStateSaved(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ServiceStateDeleted extends ServiceState {
  final int index;

  const ServiceStateDeleted(this.index);

  @override
  List<Object?> get props => [index];
}

class ServiceStateError extends ServiceState {
  final dynamic error;

  const ServiceStateError(this.error);

  @override
  List<Object> get props => [error];
}