import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
  @override
  List<Object> get props => [];
}

class ServiceFetchList extends ServiceEvent {
  const ServiceFetchList();
  @override
  List<Object> get props => [];
}

class ServiceDelete extends ServiceEvent {
  final int id;
  const ServiceDelete(this.id);
  @override
  List<Object> get props => [id];
}

class ServiceUpdate extends ServiceEvent {
  final ServiceEntity entity;
  const ServiceUpdate(this.entity);
  @override
  List<Object> get props => [entity];
}

class ServiceInsert extends ServiceEvent {
  final ServiceEntity entity;
  const ServiceInsert(this.entity);
  @override
  List<Object> get props => [entity];
}