import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:equatable/equatable.dart';

class ServiceCategoryState extends Equatable {
  const ServiceCategoryState();
  @override
  List<Object?> get props => [];
}

class ServiceCategoryStateIdle extends ServiceCategoryState {}

class ServiceCategoryStateLoading extends ServiceCategoryState {}

class ServiceCategoryStateSuccess extends ServiceCategoryState {
  final List<ServiceCategoryEntity> listServiceCategoryEntity;

  const ServiceCategoryStateSuccess(this.listServiceCategoryEntity);

  @override
  List<Object?> get props => [listServiceCategoryEntity];
}

class ServiceCategoryStateSaved extends ServiceCategoryState {
  final ServiceCategoryEntity entity;

  const ServiceCategoryStateSaved(this.entity);

  @override
  List<Object?> get props => [entity];
}

class ServiceCategoryStateDeleted extends ServiceCategoryState {
  final int index;

  const ServiceCategoryStateDeleted(this.index);

  @override
  List<Object?> get props => [index];
}

class ServiceCategoryStateError extends ServiceCategoryState {
  final dynamic error;

  const ServiceCategoryStateError(this.error);

  @override
  List<Object> get props => [error];
}
